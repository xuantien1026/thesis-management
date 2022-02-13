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
class Student < User
  DKMH = %w[DCLV LVTN].freeze
  EDUCATION_PROGRAMS = %w[CQ CLC VLVH TC].freeze # Chinh quy, Chat luong cao, Vua lam vua hoc, Tai chuc

  scope :without_proposal, -> { where.not(id: ThesisProposalMember.pluck(:student_id)) }

  validates :dkmh, inclusion: DKMH
  validates :education_program,
            inclusion: { in: EDUCATION_PROGRAMS,
                         message: "không hợp lệ. Chương trình đào tạo phải là 1 trong những giá trị sau: #{EDUCATION_PROGRAMS.join(',')}" }
  validates :mssv, :major, presence: true

  def profile
    {
      'Họ và tên' => name,
      'Email' => email,
      'MSSV' => mssv,
      'Đăng kí môn học' => dkmh,
      'Chương trình đào tạo' => education_program,
      'Chuyên ngành' => major
    }
  end

  def mssv_name
    "#{mssv} - #{name}"
  end
end
