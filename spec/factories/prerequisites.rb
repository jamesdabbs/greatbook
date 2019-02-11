# == Schema Information
#
# Table name: prerequisites
#
#  id             :bigint(8)        not null, primary key
#  minimum_grade  :string           not null
#  course_id      :bigint(8)        not null
#  requirement_id :bigint(8)        not null
#
# Indexes
#
#  index_prerequisites_on_course_id       (course_id)
#  index_prerequisites_on_requirement_id  (requirement_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (requirement_id => courses.id)
#

FactoryBot.define do
  factory :prerequisite do
    course
    requirement   { build(:course) }
    minimum_grade { %w(A B C).shuffle }
  end
end
