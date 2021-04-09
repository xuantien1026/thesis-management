# frozen_string_literal: true

namespace :import do
  task faculties: :environment do
    cse = Faculty.create(name: 'Computer Science & Engineering')
    ce = Faculty.create(name: 'Electrical & Electronic Engineering')
    Faculty.create(name: 'Chemical Engineering')
    Faculty.create(name: 'Mechanical Engineering')
    Faculty.create(name: 'Civil Engineering')
    Faculty.create(name: 'Environment & Natural Resources')
    Faculty.create(name: 'Geology & Petroleum Engineering')
    Faculty.create(name: 'Transportation Engineering')
    Faculty.create(name: 'Materials Technology')

    Department.update_all(faculty_id: cse.id)
    Department.create(name: 'Basic Electrical & Electronics Engineering', faculty: ce)
    Department.create(name: 'Electronics Engineering', faculty: ce)
    Department.create(name: 'Telecommunications Engineering', faculty: ce)
    Department.create(name: 'Automatic Control Engineering', faculty: ce)
    Department.create(name: 'Power Equipment & Machines Engineering', faculty: ce)
    Department.create(name: 'Power Systems Engineering', faculty: ce)
    Department.create(name: 'Power Delivery Engineering', faculty: ce)
  end
end
