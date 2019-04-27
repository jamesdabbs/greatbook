require 'rails_helper'

RSpec.describe GradesController do
  let(:section)       { create(:section, with_students: [student]) }
  let(:other_section) { create(:section, with_students: [student]) }

  let(:admin)      { create(:admin) }
  let(:instructor) { section.instructor }
  let(:student)    { create(:student) }

  before { as user }

  context 'as an admin' do
    let(:user) { create(:admin) }

    it 'can set grades' do
      post section_student_grade_path(section, student), params: { grade: 'A' }

      expect(response).to have_http_status :created
      expect(json.grade).to eq 'A'
    end

    it 'can update grades' do
      patch section_student_grade_path(section, student), params: { grade: 'A' }

      expect(response).to have_http_status :ok
      expect(json.grade).to eq 'A'
    end
  end

  context 'as the instructor' do
    let(:user) { section.instructor }

    it 'can set grades' do
      post section_student_grade_path(section, student), params: { grade: 'B' }

      expect(response).to have_http_status :created
      expect(json.grade).to eq 'B'
    end

    it 'can update grades' do
      patch section_student_grade_path(section, student), params: { grade: 'B' }

      expect(response).to have_http_status :ok
      expect(json.grade).to eq 'B'
    end
  end

  context 'as another teacher' do
    let(:user) { create(:teacher) }

    it 'can set grades' do
      post section_student_grade_path(section, student), params: { grade: 'B' }

      expect(response).to have_http_status :forbidden
      expect(json.error).to be_present
    end

    it 'can update grades' do
      patch section_student_grade_path(section, student), params: { grade: 'B' }

      expect(response).to have_http_status :forbidden
      expect(json.error).to be_present
    end
  end

  # context 'as an assistant' do
  #   let(:user) { create(:assistant, section: section) }

  #   it 'can set grades for other students' do
  #     post section_student_grade_path(section, student), params: { grade: 'C' }

  #     expect(response).to have_http_status :created
  #     expect(json.grade).to eq 'C'
  #   end

  #   it 'cannot set grades for the assistant' do
  #     post section_student_grade_path(section, user), params: { grade: 'A' }

  #     expect(response).to have_http_status :forbidden
  #     expect(json.error).to be_present
  #   end

  #   it 'cannot update grades' do
  #     patch section_student_grade_path(section, student), params: { grade: 'C' }

  #     expect(response).to have_http_status :forbidden
  #     expect(json.error).to be_present
  #   end
  # end

  context 'as a student' do
    let(:user) { student }

    it 'can set grades' do
      post section_student_grade_path(section, student), params: { grade: 'A' }

      expect(response).to have_http_status :forbidden
      expect(json.error).to be_present
    end

    it 'can update grades' do
      patch section_student_grade_path(section, student), params: { grade: 'A' }

      expect(response).to have_http_status :forbidden
      expect(json.error).to be_present
    end
  end
end
