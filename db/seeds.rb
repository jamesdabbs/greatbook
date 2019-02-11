puts 'Generating randomized seed data'

include FactoryBot::Syntax::Methods

[
  Prerequisite,
  Course,
  User
].each(&:delete_all)

students = Array.new(100) { create(:student) }
courses = Array.new(30) { create(:course) }

10.times { create(:prerequisite, requirement: courses.sample) }
