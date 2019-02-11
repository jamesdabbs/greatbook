# == Schema Information
#
# Table name: rooms
#
#  id       :bigint(8)        not null, primary key
#  capacity :integer
#  number   :string
#

FactoryBot.define do
  factory :room do
    number   { rand(100 .. 400) }
    capacity { rand(12 .. 250) }
  end
end
