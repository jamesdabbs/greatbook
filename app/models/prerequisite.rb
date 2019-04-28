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

class Prerequisite < ApplicationRecord
  belongs_to :course
  belongs_to :requirement, class_name: 'Course'

  serialize :minimum_grade, Grade
  validates :minimum_grade, inclusion: { in: Grade.all }
end
