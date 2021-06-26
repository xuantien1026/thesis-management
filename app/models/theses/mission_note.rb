module Theses
  class MissionNote
    def initialize(thesis)
      @thesis = thesis
    end

    delegate :faculty, :department, :students, :major, :title, :mission, :assignment_date, :completion_date, :advisors, :primary_advisor, to: :thesis

    def school_class
      raise NotImplementedError
    end

    def head_of_department
      department.head
    end

    private

    attr_reader :thesis
  end
end
