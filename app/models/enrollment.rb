# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint(8)        not null, primary key
#  grade      :string
#  section_id :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_enrollment_on_section_id  (section_id)
#  index_enrollment_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#  fk_rails_...  (user_id => users.id)
#

class Enrollment < ApplicationRecord
  belongs_to :section
  belongs_to :user

  serialize :grade, Grade
  validates :grade, inclusion: { in: Grade.all, allow_nil: true }
end
