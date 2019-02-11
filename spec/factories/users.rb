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

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email.sub('@', "#{n}@") }

    password { 'hunter2' }
    name     { Faker::Name.name }

    transient do
      in_good_standing { true }
    end

    after :build do |user, ev|
      unless ev.in_good_standing
        user.on_probation = true
      end
    end

    factory :admin do
      after :build do |teacher, evaluator|
        teacher.role = User::ADMIN
      end
    end

    factory :teacher do
      after :build do |teacher, evaluator|
        teacher.role = User::TEACHER
      end
    end

    factory :student do
      transient do
        with_grades { {} }
        in_term     { create(:term) }
      end

      after :build do |student, evaluator|
        student.role = User::STUDENT
      end

      after :create do |student, ev|
        ev.with_grades.each do |course, grade|
          section = create(:section, course: course, term: ev.in_term)

          student.enrollment.create!(
            section: section,
            grade:   grade
          )
        end
      end
    end
  end
end
