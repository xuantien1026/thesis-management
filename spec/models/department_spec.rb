# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  short_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  faculty_id :bigint           not null
#
# Indexes
#
#  index_departments_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#
require 'rails_helper'

RSpec.describe Department, type: :model do
  describe '#head' do
    let(:department) { create :department }
    let(:lecturer) { create :lecturer, department: department }

    it 'returns the lecturer of current department whose role is head of department' do
      lecturer.add_role :head_of_department

      expect(department.head).to eq lecturer
    end
  end
end
