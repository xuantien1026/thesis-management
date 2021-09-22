# frozen_string_literal: true

module Lecturers
  class ImportMap
    include ActiveModel::Model

    EXCEL_COLUMNS = ('A'..'Z').map { |column| [column, column.ord - 65] }

    attr_reader :header_rows, :mscb, :name, :email, :department

    validates :header_rows, numericality: { greater_than_or_equal_to: 0 }

    def header_rows=(header_rows)
      @header_rows = header_rows.to_i
    end

    def mscb=(mscb)
      @mscb = mscb.to_i
    end

    def name=(name)
      @name = name.to_i
    end

    def email=(email)
      @email = email.to_i
    end

    def department=(department)
      @department = department.to_i
    end
  end
end
