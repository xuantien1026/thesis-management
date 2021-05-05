# frozen_string_literal: true

class CreateThesisProposal
  include Interactor

  delegate :thesis_proposal_params, :students, :primary_advisor, to: :context

  def call # rubocop:disable Metrics/AbcSize
    context.thesis_proposal = ThesisProposal.new(thesis_proposal_params)
    context.fail!(errors: thesis_proposal.errors.full_messages) unless context.thesis_proposal.save

    students.each do |student|
      context.thesis_proposal.create_member(student)
    end

    context.thesis_proposal.thesis_proposal_advisors.create(lecturer: primary_advisor, primary: true)
  end
end
