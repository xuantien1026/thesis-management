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
