# == Schema Information
#
# Table name: sections
#
#  id            :bigint(8)        not null, primary key
#  course_id     :bigint(8)        not null
#  instructor_id :bigint(8)        not null
#  room_id       :bigint(8)        not null
#  term_id       :bigint(8)        not null
#
# Indexes
#
#  index_courses_on_course_id      (course_id)
#  index_courses_on_instructor_id  (instructor_id)
#  index_courses_on_room_id        (room_id)
#  index_courses_on_term_id        (term_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (instructor_id => users.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (term_id => terms.id)
#

require 'rails_helper'

RSpec.describe Section do
  let(:term) { create(:term) }

  def section(course, term: nil)
    term ||= self.term
    @sections ||= {}
    @sections[[course, term]] ||= create(:section, course: course, term: term)
  end

  context '.admit?' do
    it 'allows classes with no prerequisites' do
      course = create(:course, with_prerequisites: {})
      student = create(:student)

      expect(section(course).admit?(student)).to eq true
    end

    it 'requires students to be in good standing' do
      course = create(:course, with_prerequisites: {})
      student = create(:student, in_good_standing: false)

      expect(section(course).admit?(student)).to eq false
    end

    it 'requires students to have takes the prerequisites' do
      prereq = create(:course)
      course = create(:course, with_prerequisites: { prereq => 'C' })
      student = create(:student)

      expect(section(course).admit?(student)).to eq false
    end

    xit 'handles +/- prereqs' do
      prereq = create(:course)
      course = create(:course, with_prerequisites: { prereq => 'C' })
      student = create(:student, with_grades: { prereq => 'C+' })

      expect(section(course).admit?(student)).to eq true
    end

    it 'requires students to met the minimum grade in prerequisites' do
      prereq1 = create(:course)
      prereq2 = create(:course)
      course = create(:course, with_prerequisites: {
        prereq1 => 'C',
        prereq2 => 'C'
      })
      student = create(:student, with_grades: {
        prereq1 => 'B',
        prereq2 => 'D'
      })

      expect(section(course).admit?(student)).to eq false
    end

    it 'allows students that have met the minimum grade in prerequisites' do
      prereq1 = create(:course)
      prereq2 = create(:course)
      course = create(:course, with_prerequisites: {
        prereq1 => 'C',
        prereq2 => 'C'
      })
      student = create(:student, with_grades: {
        prereq1 => 'B',
        prereq2 => 'C'
      })

      expect(section(course).admit?(student)).to eq true
    end
  end
end
