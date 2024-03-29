# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  dkmh                   :string
#  education_program      :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  major                  :string
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
class Lecturer < User
  belongs_to :department, optional: true

  validates :mscb, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :department, presence: true

  delegate :faculty, to: :department

  scope :by_faculty, ->(faculty) { joins(:department).where(departments: { faculty_id: faculty.id }) }

  def to_s
    name
  end

  def profile
    {
      'Họ và tên' => name,
      'Email' => email,
      'MSCB' => mscb,
      'Bộ môn' => department,
      'Khoa' => faculty
    }
  end
end
