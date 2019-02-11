class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def create
    require_role! :admin
    @course = Course.create! course_params
    render :show, status: :created
  end

  private

  def course_params
    params.require(:course).permit(:name, :short_code, :credit_hours)
  end
end