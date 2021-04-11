# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id                :bigint           not null, primary key
#  description       :text
#  education_program :string
#  english_title     :string
#  max_student_count :integer          default(1), not null
#  mission           :string
#  ordering          :integer
#  references        :string           default([]), is an Array
#  semester          :string
#  status            :integer          default(0)
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class ThesisProposal < ApplicationRecord
  composed_of :semester
  composed_of :education_program

  validates :title, presence: true

  enum status: { 'waiting_for_approval' => 0, 'department_approved' => 1, 'faculty_approved' => 2 }
end
