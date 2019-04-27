# == Schema Information
#
# Table name: section_assistants
#
#  id         :bigint(8)        not null, primary key
#  section_id :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_section_assistants_on_section_id  (section_id)
#  index_section_assistants_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#  fk_rails_...  (user_id => users.id)
#

class SectionAssistant < ApplicationRecord
  belongs_to :section
  belongs_to :user

  validates_uniqueness_of :user, scope: :section
end
