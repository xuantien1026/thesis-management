class ThesisProposal::FinalEvaluationSet
  include ActiveModel::Model

  attr_writer :evaluations

  def initialize(lecturer, semester)
    @lecturer = lecturer
    @semester = semester
  end

  def thesis_proposals
    @thesis_proposals = ThesisProposal.includes(:students, :final_evaluation).by_lecturer(lecturer).tap { |collection| collection.each { |tp| tp.build_final_evaluation if tp.final_evaluation.nil?} }
  end

  def evaluated?
    thesis_proposals.all? { |thesis_proposal| thesis_proposal.final_evaluation.persisted? }
  end

  def save
    ApplicationRecord.transaction do
      thesis_proposals.each do |thesis_proposal|
        thesis_proposal.final_evaluation.update(evaluations[thesis_proposal.id])
      end
    end
  end

  private

  attr_reader :lecturer, :evaluations
end