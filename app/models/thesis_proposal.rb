# frozen_string_literal: true

# == Schema Information
#
# Table name: thesis_proposals
#
#  id         :bigint           not null, primary key
#  topic_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ThesisProposal < ApplicationRecord
  belongs_to :topic

  delegate :title, :description, :primary_advisor, :program, :mission, :students, to: :topic
end
