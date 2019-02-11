class GradesController < ApplicationController
  def update
    section = Section.find(params[:section_id])
    student = section.students.find(params[:student_id])

    unless can_update_grades?(section)
      raise User::RoleRequired.new(required: 'teacher', actual: current_user.role)
    end

    grade = section.set_grade(student: student, grade: params[:grade])

    render json: { grade: grade }
  end

  private

  def can_update_grades?(section)
    case current_user.role.to_s
    when 'admin'
      true
    when 'teacher'
      section.instructor_id == current_user.id
    else
      false
    end
  end
end
