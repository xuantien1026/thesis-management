# frozen_string_literal: true

class Role < ApplicationRecord
  ROLES = %w[admin student lecturer head_of_department head_of_faculty].freeze

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true
  validates :name, inclusion: ROLES

  scopify
end
