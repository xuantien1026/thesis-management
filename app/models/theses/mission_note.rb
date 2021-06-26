# frozen_string_literal: true

module Theses
  class MissionNote
    def initialize(thesis)
      @thesis = thesis
    end

    delegate :faculty, :department, :students, :major, :title, :mission, :assignment_date, :completion_date,
             :advisors, :primary_advisor, to: :thesis

    def school_class
      raise NotImplementedError
    end

    def head_of_department
      department.head
    end

    def students_formatted
      students.map { |student| "HỌ VÀ TÊN: #{student.name}\tMSSV: #{student.mssv}\t" }
    end

    def advisors_formatted
      thesis.lecturers.map.with_index(1) { |lecturer, i| "#{i}) #{lecturer.name}\t" }
    end

    private

    attr_reader :thesis
  end
end
