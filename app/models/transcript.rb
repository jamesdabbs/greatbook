class Transcript
  GRADE_SCORES = Grade::SCORES

  attr_reader :student, :enrollment

  def self.for(student:, terms: nil, courses: nil)
    enrollment = student.enrollment
    enrollment = enrollment.where(sections: { term_id: terms.map(&:id)} ) if terms
    enrollment = enrollment.where(sections: { course_id: courses.map(&:id)} ) if courses

    new(student: student, enrollment: enrollment)
  end

  def initialize(student:, enrollment:)
    @student = student
    @enrollment = enrollment
  end

  def gpa
    score = 0.0
    hours = 0
    enrollment.each do |enrollment|
      score += GRADE_SCORES[enrollment.grade] * enrollment.section.course.credit_hours
      hours += enrollment.section.course.credit_hours
    end
    (score / hours).round(2)
  end
end
