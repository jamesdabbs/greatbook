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

require 'rails_helper'

RSpec.describe User do
  let(:cs101) { create(:course) }
  let(:math101) { create(:course) }
  let(:eng101) { create(:course) }

  context '.grades' do
    let(:grades) {
      {
        cs101 => 'A',
        math101 => 'B',
        eng101 => 'C'
      }
    }

    let(:student) { create(:student, with_grades: grades) }

    it 'can show grades for all courses' do
      expect(student.grades).to eq(grades)
    end

    it 'can show grades for some courses' do
      expect(student.grades(courses: [cs101, math101])).to eq(
        cs101 => 'A',
        math101 => 'B'
      )
    end
  end
end
