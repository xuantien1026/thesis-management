# Department
departments = [
  { name: 'Department of Computer Science', program: 'CS' },
  { name: 'Department of System and Networking', program: 'CS' },
  { name: 'Department of Information System', program: 'CS' },
  { name: 'Department of Software Engineering', program: 'CS' },
  { name: 'Department of Computer Engineering', program: 'CE' },
]
departments.each { |d| Department.create(d) }
