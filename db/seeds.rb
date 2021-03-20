# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create email: 'admin@hcmut.edu.vn', password: 'password'
admin.add_role :admin

students = [
{ email: 'tien.nguyen.1026@hcmut.edu.vn', password: 'password' },
{ email:  'nguyen.van.a@hcmut.edu.vn', password: 'password' },
]
students.each { |s| User.create s }

departments = [
  { name: 'Department of Computer Science', program: 'CS', head: admin },
  { name: 'Department of System and Networking', program: 'CS', head: admin },
  { name: 'Department of Information System', program: 'CS', head: admin },
  { name: 'Department of Software Engineering', program: 'CS', head: admin },
  { name: 'Department of Computer Engineering', program: 'CE', head: admin },
]
departments.each.with_index(1) do |department, index|
  dept = Department.create department
  lecturer = User.create(email: "lecturer-#{index}@hcmut.edu.vn", password: 'password', department: dept)
  lecturer.add_role :lecturer
end