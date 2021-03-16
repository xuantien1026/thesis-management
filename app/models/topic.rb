class Topic < ApplicationRecord
  has_many :thesis_applications, dependent: :destroy
end
