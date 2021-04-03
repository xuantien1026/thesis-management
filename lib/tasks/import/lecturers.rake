# frozen_string_literal: true

namespace :import do
  desc 'Import lecturers from csv file exported from Mrs Trang spreadsheet'
  task :lecturers, [:filename] => :environment do |_, args|
    filepath = Rails.root.join('db', 'fixtures', args.filename)

    LecturersImporter.import(filepath)
  end
end
