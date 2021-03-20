# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :head, class_name: 'User'
  has_many :lecturers, class_name: 'User'
end
