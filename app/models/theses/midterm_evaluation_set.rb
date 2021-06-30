# frozen_string_literal: true

module Theses
  # Represent evaluations of all theses of one lecturer in on semester
  class MidtermEvaluationSet
    include ActiveModel::Model

    def initialize(lecturer, semester)
      @lecturer = lecturer
      @semester = semester
    end

    attr_writer :evaluations

    def theses
      @theses ||= Thesis.includes(members: %i[student midterm_evaluation])
                        .by_lecturer(@lecturer)
                        .where(semester: @semester)
    end

    def members
      @members ||= theses.map(&:members).flatten
    end

    def evaluated?
      MidtermEvaluation.joins(:member).where(member: { thesis_id: theses.ids }).any?
    end

    def persisted?
      evaluated?
    end

    def save
      return false unless valid?

      ApplicationRecord.transaction do
        members.each { |member| member.create_midterm_evaluation!(evaluations[member.id]) }
      end

      true
    end

    private

    attr_reader :evaluations
  end
end
