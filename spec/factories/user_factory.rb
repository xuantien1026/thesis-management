# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  department_id          :bigint
#  name                   :string           not null
#  mssv                   :integer
#  type                   :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint
#  invitations_count      :integer          default(0)
#  mscb                   :string
#
FactoryBot.define do
  factory :user, aliases: %i[primary_advisor head] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    transient do
      department { create :department }
    end
  end

  trait :as_student do
    after :create do |user|
      user.add_role :student
    end
  end

  trait :as_lecturer do
    after :create do |user, evaluator|
      user.add_role :lecturer
      user.update(department: evaluator.department)
    end
  end

  trait :as_head_of_department do
    after :create do |user|
      user.add_role :head_of_department
    end
  end

  trait :as_head_of_faculty do
    after :create do |user|
      user.add_role :head_of_faculty
    end
  end
end
