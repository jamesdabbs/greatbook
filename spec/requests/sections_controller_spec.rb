require 'rails_helper'

RSpec.describe SectionsController do
  let(:term) { create :term }
  let(:course) { create :course }
  let(:instructor) { create :teacher }
  let(:room) { create :room }

  context '#create' do
    it 'allows admins to create a section' do
      as :admin

      post course_term_sections_path(course, term), params: {
        section: {
          instructor_id: instructor.id,
          room_id: room.id
        }
      }

      expect(response).to have_http_status :created
      expect(json.course_id).to eq course.id
    end

    it 'does not allow teachers to create a section' do
      as :teacher

      post course_term_sections_path(course, term), params: {
        section: {
          instructor_id: instructor.id,
          room_id: room.id
        }
      }

      expect(response).to have_http_status :forbidden
    end
  end

  context '#update' do
    it 'allows admins to update a section' do
      section = create :section

      as :admin

      patch section_path(section), params: {
        section: {
          room_id: room.id
        }
      }

      expect(response).to have_http_status :ok
      expect(json.room_id).to eq room.id
    end
  end
end