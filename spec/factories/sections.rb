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

FactoryBot.define do
  factory :section do
    course
    term
    room
    instructor { create(:teacher) }

    transient do
      with_students { 0 }
    end

    after :create do |section, ev|
      students =
        case ev.with_students
        when Array
          ev.with_students
        when Integer
          Array.new(ev.with_students) { create(:student) }
        else
          []
        end

      students.each { |student| section.enroll(student: student) }
    end
  end
end
