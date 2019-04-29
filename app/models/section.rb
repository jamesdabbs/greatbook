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

class Section < ApplicationRecord
  belongs_to :course
  belongs_to :term
  belongs_to :room
  belongs_to :instructor, class_name: 'User'

  has_many :enrollment
  has_many :students, through: :enrollment, source: :user

  has_many :section_assistants
  has_many :assistants, through: :section_assistants, source: :user

  def admit?(user)
    return false unless user.role == 'student'
    return false if user.on_probation?
    return false if enrollment.count >= room.capacity

    requirements = course.requirements

    grades = user.grades(courses: requirements.keys)

    requirements.all? do |course, minimum_grade|
      grades[course]&.at_least?(minimum_grade)
    end
  end

  def enroll(student:)
    enrollment.where(user: student).first_or_create!
  end

  def set_grade(student:, grade:)
    e = enrollment.find_by!(user: student)
    e.update!(grade: grade)
    e.grade
  end

  delegate :credit_hours, to: :course

  class Role
    def self.for(section, user)
      role = user.role
      if role == 'admin'
        AdminRole
      elsif role == 'teacher'
        TeacherRole
      elsif section.assistants.include?(user)
        AssistantRole
      else
        StudentRole
      end.new(section, user)
    end

    attr_reader :section, :user

    def initialize(section, user)
      @section = section
      @user = user
    end

    def can_create_grades?(**)
      can_update_grades?
    end

    def can_update_grades?
      raise NotImplementedError
    end
  end

  class AdminRole < Role
    def can_update_grades?
      true
    end
  end

  class TeacherRole < Role
    def can_update_grades?
      section.instructor_id == user.id
    end
  end

  class AssistantRole < Role
    def can_create_grades?(student:)
      user != student
    end

    def can_update_grades?
      false
    end
  end

  class StudentRole < Role
    def can_update_grades?
      false
    end
  end

  def role_for(user)
    Role.for(self, user)
  end
end
