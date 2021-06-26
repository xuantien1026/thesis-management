# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string           not null
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
class Department < ApplicationRecord
  has_many :lecturers, dependent: :restrict_with_error
  belongs_to :faculty

  def head
    Lecturer.where(department: self).with_role(:head_of_department).first
  end

  def to_s
    name
  end
end
