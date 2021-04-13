# frozen_string_literal: true

namespace :import do
  task initial_data: :environment do
    lvtn = Rails.root.join('db/fixtures/lvtn.csv')
    dk = Rails.root.join('db/fixtures/dk.csv')

    LecturersImporter.import(lvtn)
    StudentsImporter.import(dk)
    ThesesImporter.import(lvtn)
    ThesisMembersImporter.import(dk)
  end
end
