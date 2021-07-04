# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ThesisProposals', type: :system do
  def fill_in_topic_info
    visit thesis_proposals_path
    click_on 'Đề Cương Luận Văn Mới'
    fill_in 'Đề tài', with: 'Tên đề tài'
    fill_in 'Mô tả', with: 'Mô tả đề tài đây'
    fill_in 'Nhiệm vụ', with: 'Nhiệm vụ của đề tài'
    fill_in 'Tài liệu tham khảo', with: 'GVHD cung cấp'
    select 'Computer Engineering', from: 'Ngành'
  end

  before do
    create_list :semester, 2
    current_faculty.majors.create(name: 'Computer Science')
    current_faculty.majors.create(name: 'Computer Engineering')
  end

  describe 'Lecturer creating a new topic' do
    include_context :browser_signed_in_as_lecturer

    it 'success' do
      fill_in_topic_info
      fill_in 'Số lượng sinh viên', with: 3
      click_on 'Submit'

      expect(page).to have_content('Tạo đề cương luận văn thành công')
      expect(page).to have_content('Tên đề tài')
      expect(page).to have_content('Mô tả đề tài đây')
      expect(page).to have_content('Nhiệm vụ của đề tài')
      expect(page).to have_content('GVHD cung cấp')
      expect(page).to have_content('3')
    end
  end

  describe 'Lecturer creating a new topic and assign students' do
    include_context :browser_signed_in_as_lecturer

    let(:students) { create_list :student, 5 }

    before do
      students
    end

    it 'success' do
      fill_in_topic_info
      fill_in 'Số lượng sinh viên', with: 2
      select students.first.name.to_s, from: 'student_ids[]'
      select students.second.name.to_s, from: 'student_ids[]'
      click_on 'Submit'

      expect(page).to have_content('Tạo đề cương luận văn thành công')
      expect(page).to have_content(students.first.name.to_s)
      expect(page).to have_content(students.second.name.to_s)
    end
  end
end
