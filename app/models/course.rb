# == Schema Information
#
# Table name: courses
#
#  id           :bigint(8)        not null, primary key
#  name         :string           not null
#  short_code   :string           not null
#  credit_hours :integer          not null
#

class Course < ApplicationRecord
  has_many :prerequisites, dependent: :destroy
  has_many :sections, dependent: :destroy

  validates :name, presence: true
  validates :short_code, presence: true, uniqueness: true
  validates :credit_hours, numericality: { greater_than: 0 }

  def requirements
    @requirements ||= prerequisites.
      includes(:requirement).
      each_with_object({}) do |prereq, requirements|
        requirements[prereq.requirement] = prereq.minimum_grade
      end
  end
end
