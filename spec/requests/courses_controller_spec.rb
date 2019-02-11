require 'rails_helper'

RSpec.describe CoursesController do
  context '#index' do
    it 'shows all courses' do
      3.times { create :course }

      get '/courses'

      expect(json.courses.count).to eq 3
    end
  end

  context '#create' do
    it 'allows admins to create a course' do
      as :admin

      post '/courses', params: {
        course: {
          name: 'New Course',
          short_code: 'NC101',
          credit_hours: 3
        }
      }

      expect(response).to have_http_status :created
      expect(json.name).to eq 'New Course'
      expect(json.id).to be_present
    end

    it 'shows validation errors' do
      as :admin

      post '/courses', params: {
        course: {
          name: 'New Course',
          credit_hours: 3
        }
      }

      expect(response).to have_http_status :unprocessable_entity
      expect(json.error.short_code).to eq ["can't be blank"]
    end

    it 'does not allow teachers to update' do
      as :teacher

      post '/courses', params: {
        course: {
          name: 'New Course',
          short_code: 'NC101',
          credit_hours: 3
        }
      }

      expect(response).to have_http_status :forbidden
    end
  end
end
