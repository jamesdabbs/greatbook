# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint(8)        not null, primary key
#  grade      :string
#  section_id :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_enrollment_on_section_id  (section_id)
#  index_enrollment_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Enrollment do
  context '#grade' do
    it 'can be created without a grade' do
      enrollment = create(:enrollment, grade: nil)
      expect(enrollment.grade).to eq nil
    end

    it 'can be created without a grade' do
      enrollment = create(:enrollment, grade: 'F')
      expect(enrollment.grade).to eq 'F'
    end

    xit 'can be created with minus grade' do
      enrollment = create(:enrollment, grade: 'B-')
      expect(enrollment.grade).to eq 'B-'
    end
  end
end
