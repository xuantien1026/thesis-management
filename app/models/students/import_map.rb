# frozen_string_literal: true

module Students
  class ImportMap
    include ActiveModel::Model

    EXCEL_COLUMNS = ('A'..'Z').map { |column| [column, column.ord - 65] }

    attr_reader :header_rows, :name, :email, :mssv, :dkmh, :education_program, :major

    validates :header_rows, numericality: { greater_than_or_equal_to: 0 }

    def header_rows=(header_rows)
      @header_rows = header_rows.to_i
    end

    def name=(name)
      @name = name.to_i
    end

    def email=(email)
      @email = email.to_i
    end

    def mssv=(mssv)
      @mssv = mssv.to_i
    end

    def dkmh=(dkmh)
      @dkmh = dkmh.to_i
    end

    def education_program=(education_program)
      @education_program = education_program.to_i
    end

    def major=(major)
      @major = major.to_i
    end
  end
end
