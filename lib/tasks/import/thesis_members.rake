# frozen_string_literal: true

namespace :import do
  desc 'Import thesis members from csv file exported from Mrs Trang spreadsheet'
  task :thesis_members, [:filename] => :environment do |_, args|
    filepath = Rails.root.join('db', 'fixtures', args.filename)

    ThesisMembersImporter.import(filepath)
  end
end
