# frozen_string_literal: true

# == Schema Information
#
# Table name: faculties
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Faculty < ApplicationRecord
  has_many :majors, dependent: :destroy
  has_many :departments, dependent: :destroy

  def to_s
    name
  end
end
