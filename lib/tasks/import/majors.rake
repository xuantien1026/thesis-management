# frozen_string_literal: true

namespace :import do
  task majors: :environment do
    cse = Faculty.find_by(name: 'Computer Science & Engineering')
    ee  = Faculty.find_by(name: 'Electrical & Electronic Engineering')

    cse.majors.create(name: 'Computer Science')
    cse.majors.create(name: 'Computer Engineering')
    ee.majors.create(name: 'Electrical')
    ee.majors.create(name: 'Electronics & Telecommunication')
    ee.majors.create(name: 'Automation Control')
  end
end
