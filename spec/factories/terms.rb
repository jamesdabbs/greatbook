# == Schema Information
#
# Table name: terms
#
#  id         :bigint(8)        not null, primary key
#  quarter    :string
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :term do
    quarter { Term::QUARTERS.sample }
    year    { rand(2018 .. 2025) }
  end
end
