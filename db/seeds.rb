# Create faculties
cse = Faculty.create(name: 'Computer Science & Engineering')
ee = Faculty.create(name: 'Electrical & Electronic Engineering')
Faculty.create(name: 'Chemical Engineering')
Faculty.create(name: 'Mechanical Engineering')
Faculty.create(name: 'Civil Engineering')
Faculty.create(name: 'Environment & Natural Resources')
Faculty.create(name: 'Geology & Petroleum Engineering')
Faculty.create(name: 'Transportation Engineering')
Faculty.create(name: 'Materials Technology')

# Computer Science & Engineering deparments
Department.create(name: 'Computer Science', short_name: 'KHMT', faculty: cse)
Department.create(name: 'System and Networking', short_name: 'HT&MMT', faculty: cse)
Department.create(name: 'Information System', short_name: 'HTTT', faculty: cse)
Department.create(name: 'Software Engineering', short_name: 'CNPM', faculty: cse)
Department.create(name: 'Computer Engineering', short_name: 'KTMT', faculty: cse)

# Electrical & Electronic Engineering Departments
Department.create(name: 'Basic Electrical & Electronics Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Electronics Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Telecommunications Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Automatic Control Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Power Equipment & Machines Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Power Systems Engineering', short_name: 'KHMT', faculty: ee)
Department.create(name: 'Power Delivery Engineering', short_name: 'KHMT', faculty: ee)

# Majors
cse.majors.create(name: 'Computer Science')
cse.majors.create(name: 'Computer Engineering')

ee.majors.create(name: 'Electrical')
ee.majors.create(name: 'Electronics - Telecommunication')
ee.majors.create(name: 'Automation Control')
