# frozen_string_literal: true

module ThesisProposals
  class FinalEvaluationSet
    include ActiveModel::Model

    attr_writer :evaluations

    def initialize(lecturer, semester)
      @lecturer = lecturer
      @semester = semester
    end

    def thesis_proposals
      @thesis_proposals = ThesisProposal.includes(members: %i[student
                                                              final_evaluation]).by_lecturer(lecturer).where(semester: semester)
    end

    def members
      @members = thesis_proposals.map(&:members).flatten
    end

    def evaluated?
      members.all? { |member| member.final_evaluation&.persisted? }
    end

    def save
      ApplicationRecord.transaction do
        members.each do |member|
          evaluation = FinalEvaluation.find_or_initialize_by(member: member)
          evaluation.assign_attributes(evaluations[member.id])
          evaluation.save!
        end
      end
    end

    private

    attr_reader :lecturer, :evaluations, :semester
  end
end
