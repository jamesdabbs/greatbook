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

class Term < ApplicationRecord
  has_many :sections

  QUARTERS = %w(winter spring summer fall)

  validates :quarter, inclusion: { in: QUARTERS }
  validates :year, numericality: { greater_than: 1969 }
end
