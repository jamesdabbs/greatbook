class SectionsController < ApplicationController
  def create
    require_role! :admin

    course = Course.find(params[:course_id])

    @section = course.sections.create!(
      term: Term.find(params[:term_id]),
      instructor: User.teacher.find(section_params[:instructor_id]),
      room: Room.find(section_params[:room_id])
    )

    render :show, status: :created
  end

  def update
    require_role! :admin

    @section = Section.find(params[:id])
    if section_params.include?(:instructor_id)
      @section.instructor = User.teacher.find(section_params[:instructor_id])
    end
    if section_params.include?(:room_id)
      @section.room = Room.find(section_params[:room_id])
    end

    render :show
  end

  private

  def section_params
    params.require(:section).permit(:room_id, :instructor_id)
  end
end
