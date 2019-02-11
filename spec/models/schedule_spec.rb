require 'rails_helper'

RSpec.describe Schedule do
  {
    cs101: {},
    cs102: {},
    cs201: {
      cs101: 'B',
      cs102: 'C'
    },
    cs301: {
      cs201: 'C',
    },
    ma101: {}
  }.each do |name, requirements|
    let(name) do
      prereqs = requirements.each_with_object({}) do |(other, grade), prereqs|
        prereqs[public_send(other)] = grade
      end

      create(:course, short_code: name.upcase, with_prerequisites: prereqs)
    end
  end

  let(:term) { create(:term) }

  it 'can register a student for classes' do
    student = create(:student, with_grades: {
      cs101 => 'A',
      cs102 => 'B'
    })

    sections = [cs201, ma101].map { |course| create(:section, course: course, term: term) }

    schedule = described_class.new(
      student: student,
      sections: sections
    )

    expect(schedule).to be_valid

    schedule.save!

    enrollment = student.enrollment.joins(:section).where(sections: { term: term })

    expect(enrollment.map(&:section)).to match_array sections
    expect(enrollment.map(&:grade)).to eq [nil, nil]
  end

  it 'enforces prerequisites' do
    student = create(:student, with_grades: {
      cs101 => 'C',
      cs102 => 'C'
    })

    sections = [cs201, ma101].map { |course| create(:section, course: course, term: term) }

    schedule = described_class.new(
      student: student,
      sections: sections
    )

    expect(schedule).not_to be_valid

    expect do
      schedule.save!
    end.to raise_error(Schedule::Invalid)
  end
end
