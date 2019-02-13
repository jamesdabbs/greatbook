class Schedule
  include ActiveModel::Model

  Invalid = Class.new StandardError

  attr_reader :student, :sections

  validates :credit_hours, numericality: { greater_than_or_equal_to: 6, less_than_or_equal_to: 18 }
  validate :prerequisites_are_met

  def self.for(student:, term:, courses:)
    sections = term.sections.where(course: courses).includes(:course)
    new(student: student, sections: sections)
  end

  def initialize(student:, sections:)
    @student  = student
    @sections = sections
  end

  def credit_hours
    courses.sum(&:credit_hours)
  end

  def save!
    raise Invalid unless valid?
    sections.each { |section| student.enrollment.create!(section: section) }
  end

  private

  def prerequisites_are_met
    prerequisites.each do |prereq|
      grade = grades[prereq.requirement]
      unless grade && grade <= prereq.minimum_grade_value
        errors.add(
          :prerequisites,
          :not_met,
          message: "#{prereq.course.short_code} requires a #{prereq.minimum_grade_value} or higher in #{prereq.requirement.short_code}"
        )
      end
    end
  end

  def prerequisites
    @prerequisites = Prerequisite.where(course: courses).includes(:course, :requirement)
  end

  def grades
    @grades = student.grades(courses: prerequisites.map(&:requirement))
  end

  def courses
    sections.map(&:course)
  end
end
