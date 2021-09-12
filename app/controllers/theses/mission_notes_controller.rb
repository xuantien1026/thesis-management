# frozen_string_literal: true

module Theses
  class MissionNotesController < ApplicationController
    MISSION_NOTE_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_nhiem_vu_LVTN.docx'

    before_action :set_thesis
    before_action :set_mission_note

    def show
      file_path = DocxTemplateGenerator.new(MISSION_NOTE_TEMPLATE_PATH, single_bookmarks, multiple_bookmarks).generate
      send_data(File.read(file_path), filename: 'phieu_nhiem_vu_LVTN.docx')
      File.delete(file_path)
    end

    private

    def single_bookmarks
      {
        faculty: @mission_note.faculty,
        department: @mission_note.department,
        major: @mission_note.major,
        title: @mission_note.title,
        mission: @mission_note.mission,
        assignment_date: @mission_note.assignment_date,
        completion_date: @mission_note.completion_date,
        head_of_department: @mission_note.head_of_department,
        primary_advisor: @mission_note.primary_advisor,
      }
    end

    def multiple_bookmarks
      {
        students: @mission_note.students_formatted,
        advisors: @mission_note.advisors_formatted,
      }
    end

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def set_mission_note
      @mission_note = MissionNote.new(@thesis)
    end
  end
end
