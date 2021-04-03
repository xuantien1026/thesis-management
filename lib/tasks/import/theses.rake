# frozen_string_literal: true

namespace :import do
  desc 'Import theses from csv file exported from Mrs Trang spreadsheet'
  task :theses, [:filename] => :environment do |_, args|
    filepath = Rails.root.join('db', 'fixtures', args.filename)

    ThesesImporter.import(filepath)
  end
end
