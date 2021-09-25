# frozen_string_literal: true

# == Schema Information
#
# Table name: majors
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  type       :string           default("SingleMajor"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  faculty_id :bigint           not null
#
# Indexes
#
#  index_majors_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#
class MultiMajor < Major
  has_many :major_compositions
  has_many :single_majors, through: :major_compositions

  def accept?(major)
    single_majors.any? { |single_major| single_major.accept?(major) }
  end
end
