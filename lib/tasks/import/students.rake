# frozen_string_literal: true

namespace :import do
  desc 'Import students from csv file exported from Mrs Trang spreadsheet'
  task :students, [:filename] => :environment do |_, args|
    filepath = Rails.root.join('db', 'fixtures', args.filename)

    StudentsImporter.import(filepath)
  end
end
