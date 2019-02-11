# == Schema Information
#
# Table name: courses
#
#  id           :bigint(8)        not null, primary key
#  name         :string           not null
#  short_code   :string           not null
#  credit_hours :integer          not null
#

FactoryBot.define do
  factory :course do
    name         { Faker::Company.catch_phrase }
    short_code   { "#{name.slice(0, 2).upcase}#{rand(100 .. 800)}" }
    credit_hours { [3, 4].sample }

    transient do
      with_prerequisites { {} }
    end

    after(:build) do |course, evaluator|
      evaluator.with_prerequisites.each do |requirement, grade|
        create(:prerequisite, course: course, requirement: requirement, minimum_grade: grade)
      end
    end
  end
end
