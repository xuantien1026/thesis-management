# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  mscb                   :string
#  mssv                   :integer
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  department_id          :bigint
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_department_id         (department_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
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
