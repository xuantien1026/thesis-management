class Topic < ApplicationRecord
  has_many :thesis_applications, dependent: :destroy
  belongs_to :primary_advisor, class_name: 'User', foreign_key: :primary_advisor_id

  enum status: [ :default, :department_approved, :faculty_approved ]
end
