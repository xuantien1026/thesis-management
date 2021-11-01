# Create faculties
cse = Faculty.find_or_create_by(name: 'Computer Science & Engineering')
ee = Faculty.find_or_create_by(name: 'Electrical & Electronic Engineering')

# Computer Science & Engineering deparments
cs = Department.find_or_create_by(name: 'Computer Science', short_name: 'KHMT', faculty: cse)
Department.find_or_create_by(name: 'System and Networking', short_name: 'HT&MMT', faculty: cse)
Department.find_or_create_by(name: 'Information System', short_name: 'HTTT', faculty: cse)
Department.find_or_create_by(name: 'Software Engineering', short_name: 'CNPM', faculty: cse)
Department.find_or_create_by(name: 'Computer Engineering', short_name: 'KTMT', faculty: cse)

# Electrical & Electronic Engineering Departments
Department.find_or_create_by(name: 'Basic Electrical & Electronics Engineering', short_name: 'DBEE', faculty: ee)
Department.find_or_create_by(name: 'Electronics Engineering', short_name: 'DOE', faculty: ee)

# Majors
cs_major = cse.majors.find_or_create_by(name: 'Computer Science')
ce_major = cse.majors.find_or_create_by(name: 'Computer Engineering')

ee.majors.find_or_create_by(name: 'Electrical')
ee.majors.find_or_create_by(name: 'Electronics - Telecommunication')
ee.majors.find_or_create_by(name: 'Automation Control')

puts 'Finished creating departments and faculties data'

# Major committtees
MajorCommittee.find_or_create_by(major: cs_major, name: 'Hội đồng ngành CS')
MajorCommittee.find_or_create_by(major: ce_major, name: 'Hội đồng ngành CE')

# Semester
Semester.create(number: 1, academic_year: Date.today.year, start_date: Date.today)

# Admin
admin = Lecturer.new(name: 'Admin', email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'], mscb: 0, department: cs)
if admin.save
  admin.add_role :admin
else
  puts 'Failed to create Admin, please set admin email and admin password in environment variables '\
       'ADMIN_EMAIL, ADMIN_PASSWORD and try again'
end

