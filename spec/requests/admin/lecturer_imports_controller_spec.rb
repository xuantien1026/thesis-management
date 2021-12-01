# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::LecturerImportsController, type: :request do
  include_context :signed_in_as_admin

  subject { post admin_lecturer_import_path, params: params }

  let(:params) do
    {
      excel_file: excel_file,
      import_map: { header_rows: 1, mscb: 0, name: 1, email: 2, department: 3 }
    }
  end

  before do
    current_department.update(short_name: 'KHMT')
  end

  context 'when mscb is nil' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/mscb_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Mã số cán bộ không được trống (dòng 2)')
    end
  end

  context 'when name is nil' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/name_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Tên GV không được trống (dòng 2)')
    end
  end

  context 'when email is nil' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/email_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Email không được trống (dòng 2)')
    end
  end

  context 'when department is nil' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/department_nil.xlsx' }

    it 'shows error message' do
      subject

      expect(flash.alert).to contain_exactly('Không tìm thấy bộ môn "" (dòng 2)')
    end
  end

  context 'when multiple rows has errors' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/multiple_errors.xlsx' }

    it 'shows error message for each row' do
      subject

      expect(flash.alert).to contain_exactly('Mã số cán bộ không được trống (dòng 2)',
                                             'Tên GV không được trống (dòng 3)')
    end
  end

  context 'when excel file contains duplicated MSCB' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/duplicated_mscb.xlsx' }

    it 'shows error message for each row' do
      subject

      expect(flash.alert).to contain_exactly('Mã số cán bộ bị trùng lặp (dòng 3)')
    end
  end

  context 'when department name is invalid' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/invalid_dept_name.xlsx' }

    it 'shows error message for each row' do
      subject

      expect(flash.alert).to contain_exactly('Không tìm thấy bộ môn "KTMT" (dòng 2)')
    end
  end

  context 'when excel file reaches a row with all empty values' do
    let(:excel_file) { fixture_file_upload 'lecturer_imports/empty_value_last_rows.xlsx' }

    it 'stops importing' do
      expect { subject }.to change(Lecturer, :count).from(1).to(3)
    end
  end
end
