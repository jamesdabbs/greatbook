class GradesController < ApplicationController
  def create
    unless section.role_for(current_user).can_create_grades?(student: student)
      raise NotAllowed, "Not allowed to set grades for #{student.name} in section #{section.id}"
    end

    grade = section.set_grade(student: student, grade: params[:grade])

    render json: { grade: grade }, status: :created
  end

  def update
    unless section.role_for(current_user).can_update_grades?
      raise NotAllowed, "Not allowed to revise grades for #{student.name} in section #{section.id}"
    end

    grade = section.set_grade(student: student, grade: params[:grade])

    render json: { grade: grade }
  end

  private

  def section
    @section ||= Section.find(params[:section_id])
  end

  def student
    @student = section.students.find(params[:student_id])
  end
end
