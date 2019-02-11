# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  on_probation           :boolean          default(FALSE), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  class RoleRequired < StandardError
    attr_reader :required, :actual

    def initialize(required:, actual:)
      @required = required
      @actual = actual
      super "Requires #{required} access, not #{actual}"
    end
  end

  ADMIN = 1
  TEACHER = 2
  STUDENT = 3

  enum role: {
    admin: ADMIN,
    teacher: TEACHER,
    student: STUDENT
  }

  has_many :enrollment

  def grades(courses: nil)
    history = enrollment
    history = history.where(sections: { course: courses }) if courses
    history.includes(section: :course).each_with_object({}) do |record, grades|
      grades[record.section.course] = record.grade
    end
  end
end
