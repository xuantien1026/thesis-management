# frozen_string_literal: true

module Theses
  class MissionNotesController < ApplicationController
    MISSION_NOTE_TEMPLATE_PATH = 'app/documents/pre_defense/phieu_nhiem_vu_LVTN.docx'

    before_action :set_thesis

    def show
      generate_mission_note
      send_data(File.read(mission_note_file_path), filename: 'phieu_nhiem_vu_LVTN.docx')
      File.delete(mission_note_file_path)
    end

    private

    def set_thesis
      @thesis = Thesis.find(params[:thesis_id])
    end

    def generate_mission_note # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      doc = ::Docx::Document.new(MISSION_NOTE_TEMPLATE_PATH)
      mission_note = MissionNote.new(@thesis)
      doc.bookmarks['faculty'].insert_text_before(mission_note.faculty)
      doc.bookmarks['department'].insert_text_before(mission_note.department)
      doc.bookmarks['students'].insert_multiple_lines(mission_note.students_formatted)
      doc.bookmarks['major'].insert_text_before(mission_note.major)
      doc.bookmarks['title'].insert_text_before(mission_note.title)
      doc.bookmarks['mission'].insert_text_before(mission_note.mission)
      doc.bookmarks['assignment_date'].insert_text_before(mission_note.assignment_date)
      doc.bookmarks['completion_date'].insert_text_before(mission_note.completion_date)
      doc.bookmarks['advisors'].insert_multiple_lines(mission_note.advisors_formatted)
      doc.bookmarks['head_of_department'].insert_text_before(mission_note.head_of_department)
      doc.bookmarks['primary_advisor'].insert_text_before(mission_note.primary_advisor)
      doc.save(mission_note_file_path)
    end

    def mission_note_file_path
      "tmp/mission_note_#{@thesis.id}.docx"
    end
  end
end
