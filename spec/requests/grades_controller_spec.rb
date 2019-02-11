require 'rails_helper'

RSpec.describe GradesController do
  let(:section) { create(:section, with_students: 1) }
  let(:instructor) { section.instructor }
  let(:student)  { section.students.first }

  context '#update' do
    it 'allows admins to update grades for any section' do
      as :admin

      patch section_student_grade_path(section, student), params: { grade: 'B' }

      expect(response).to have_http_status :ok
      expect(json.grade).to eq 'B'
    end

    it 'allows teachers to update grades for their sections' do
      as instructor

      patch section_student_grade_path(section, student), params: { grade: 'C' }

      expect(response).to have_http_status :ok
      expect(json.grade).to eq 'C'
    end

    it 'does not allow teachers to udpdate grades for other sections' do
      as instructor

      other_section = create(:section, with_students: [student])

      patch section_student_grade_path(other_section, student), params: { grade: 'B' }

      expect(response).to have_http_status :forbidden
    end

    it 'does not allow students to update grades for their section' do
      as student

      patch section_student_grade_path(section, student), params: { grade: 'A' }

      expect(response).to have_http_status :forbidden
    end
  end
end
