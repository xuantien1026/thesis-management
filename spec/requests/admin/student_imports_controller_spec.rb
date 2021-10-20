# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::StudentImportsController, type: :request do
  include_context :signed_in_as_admin

  subject { post admin_student_import_path, params: params }

  let(:params) do
    {
      excel_file: excel_file,
      import_map: { header_rows: 1, name: 0, email: 1, mssv: 2, dkmh: 3, education_program: 4, major: 5 }
    }
  end
  let!(:major) { create :major, faculty: current_faculty, name: 'KHMT' }

  context 'when name is nil' do
    let(:excel_file) { fixture_file_upload 'student_imports/name_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Họ và tên không được trống (dòng 2)')
    end
  end

  context 'when email is nil' do
    let(:excel_file) { fixture_file_upload 'student_imports/email_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Email không được trống (dòng 2)')
    end
  end

  context 'when education program is invalid' do
    let(:excel_file) { fixture_file_upload 'student_imports/education_program_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly("Chương trình đào tạo không hợp lệ. Chương trình đào tạo phải là 1 trong những giá trị sau: CQ,CLC,VLVH,TC (dòng 2)")
    end
  end

  context 'when major is invalid' do
    let(:excel_file) { fixture_file_upload 'student_imports/major_invalid.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly("Không tìm thấy chuyên ngành \"Điện tử\" (dòng 2)")
    end
  end

  context 'when mssv is nil' do
    let(:excel_file) { fixture_file_upload 'student_imports/mssv_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Mã số sinh viên không được trống (dòng 2)')
    end
  end

  context 'when multiple rows has errors' do
    let(:excel_file) { fixture_file_upload 'student_imports/multiple_errors.xlsx' }

    it 'shows error message for each row' do
      subject

      expect(flash.alert).to contain_exactly('Mã số sinh viên không được trống (dòng 2)',
                                             'Họ và tên không được trống (dòng 3)')
    end
  end
end
