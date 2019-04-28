require 'rails_helper'

RSpec.describe Transcript do
  let(:term) { create(:term) }

  let(:cs101)   { create(:course, credit_hours: 3) }
  let(:math101) { create(:course, credit_hours: 4) }
  let(:eng101)  { create(:course) }

  context '.gpa' do
    it 'reports all As as a 4.0' do
      student = create(:student, with_grades: {
        cs101 => 'A',
        math101 => 'A',
        eng101 => 'A'
      })

      report = described_class.for(student: student)

      expect(report.gpa).to eq 4.0
    end

    it 'reports all B+s as a 3.3' do
      student = create(:student, with_grades: {
        cs101 => 'B+',
        math101 => 'B+'
      })

      report = described_class.for(student: student)

      expect(report.gpa).to eq 3.3
    end

    it 'weights by credit hours' do
      student = create(:student, with_grades: {
        cs101 => 'C',
        math101 => 'B',
      })

      report = described_class.for(student: student)

      expect(report.gpa).to eq 2.57
    end
  end
end
