# frozen_string_literal: true

# == Schema Information
#
# Table name: defense_committees
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :defense_committee do
    name { 'MyString' }
    chairman_id { 1 }
    secretary_id { 1 }
  end
end