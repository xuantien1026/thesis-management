class Topic < ApplicationRecord
  has_many :thesis_applications, dependent: :destroy

  enum status: [ :default, :department_approved, :faculty_approved ]
end
