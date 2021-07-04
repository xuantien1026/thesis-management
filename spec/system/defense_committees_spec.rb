# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DefenseCommittees', type: :system do
  describe 'Head of department suggesting defense committee for the current semester' do
    include_context :browser_signed_in_as_head_of_department

    let!(:lecturer1) { create :lecturer, department: current_department }
    let!(:lecturer2) { create :lecturer, department: current_department }
    let!(:theses_of_lecturer1) { create_list :thesis, 3, primary_advisor: lecturer1 }
    let!(:theses_of_lecturer2) { create_list :thesis, 3, primary_advisor: lecturer2 }

    let!(:lecturer3) { create :lecturer, department: current_department }
    let!(:lecturer4) { create :lecturer, department: current_department }
    let!(:lecturer5) { create :lecturer, department: current_department }

    def suggest_committees
      visit new_dept_defense_committee_path

      fill_in 'Số lượng', with: 2
      accept_alert { click_on 'Tách hội đồng' }
      click_on 'Xem danh sách hội đồng'
    end

    it 'success' do
      suggest_committees

      all('.committee-form').each do |committee_form|
        within(committee_form) do
          select('chairman')
        end
      end

      click_on 'Submit'

      expect(page).to have_content('Đề xuất Hội Đồng Bảo Vệ thành công')
      expect(page).to have_content(lecturer1.to_s)
      expect(page).to have_content(lecturer2.to_s)

      expect(DefenseCommittee.count).to eq(2)
      expect(DefenseCommitteeMember.find_by(lecturer: lecturer1).role).to eq('chairman')
      expect(DefenseCommitteeMember.find_by(lecturer: lecturer2).role).to eq('chairman')
    end

    it 'can add member to a committee' do
      suggest_committees

      all('.committee-form').each do |committee_form|
        within(committee_form) do
          select('chairman')
          click_button('Thêm thành viên')
          select(lecturer3.to_s)
        end
      end

      click_on 'Submit'

      expect(page).to have_content('Đề xuất Hội Đồng Bảo Vệ thành công')
      expect(page).to have_content(lecturer1.to_s)
      expect(page).to have_content(lecturer2.to_s)
      expect(page).to have_content(lecturer3.to_s)

      expect(DefenseCommittee.first.chairman).to eq(lecturer1)
      expect(DefenseCommittee.first.members).to include(lecturer3)
      expect(DefenseCommittee.second.chairman).to eq(lecturer2)
      expect(DefenseCommittee.second.members).to include(lecturer3)
    end
  end
end
