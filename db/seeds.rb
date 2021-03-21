# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin
admin = User.create name: 'Admin', email: 'admin@hcmut.edu.vn', password: 'password'
admin.add_role :admin

# Students
students = [
  { name: 'Nguyen Xuan Tien', email: 'tien.nguyen.1026@hcmut.edu.vn', password: 'password' },
  { name: 'Nguyen Van A', email:  'nguyen.van.a@hcmut.edu.vn', password: 'password' },
]
students.each { |s| student = User.create s; student.add_role :student }

# Department & Department heads
department_heads = [
  { name: 'TS. CS', email: 'CS-department@hcmut.edu.vn', password: 'password' },
  { name: 'TS. SN', email: 'SN-department@hcmut.edu.vn', password: 'password' },
  { name: 'TS. IS', email: 'IS-department@hcmut.edu.vn', password: 'password' },
  { name: 'TS. SE', email: 'SE-department@hcmut.edu.vn', password: 'password' },
  { name: 'TS. CE', email: 'CE-department@hcmut.edu.vn', password: 'password' },
]

departments = [
  { name: 'Department of Computer Science', program: 'CS', head: admin },
  { name: 'Department of System and Networking', program: 'CS', head: admin },
  { name: 'Department of Information System', program: 'CS', head: admin },
  { name: 'Department of Software Engineering', program: 'CS', head: admin },
  { name: 'Department of Computer Engineering', program: 'CE', head: admin },
]
5.times do |index|
  dept_head = User.create department_heads[index]
  dept_head.add_role :head_of_department

  dept = Department.create departments[index].merge(head: dept_head)

  lecturer = User.create(name: "ThS #{index}", email: "lecturer-#{index}@hcmut.edu.vn", password: 'password', department: dept)
  lecturer.add_role :lecturer
end

# Lecturers & their topics
lecturers = User.with_role :lecturer

topics = [
  {
    title: 'Xây dựng hệ thống trao đổi phiếu mua hàng',
    description: 'Tìm hiểu, phân tích và xây dựng các hệ thống trao đổi, kinh doanh phiếu mua hàng.',
    primary_advisor: lecturers.first,
  },
  {
    title: 'Xây dựng hệ thống quản lý luận văn tốt nghiệp tại khoa Khoa học và KTMT Trường Đại học Bách khoa TP.HCM',
    description: 'Phân tích, thiết kế và xây dựng hệ thống quản lý luận văn tốt nghiệp cho khoa CSE, HCMUT',
    primary_advisor: lecturers.second,
  },
  {
    title: 'Xây dựng nền tảng quản lý, cấp phát và sử dụng tài sản/thiết bị',
    description: 'Nền tảng cho phép các tổ chức quản lý tài sản, thiết bị, cấp phát và sử dụng tài sản thiết bị cho các thành viên trong tổ chức, tracking quá trình sử dụng, thời lượng được cấp phát sử dụng, và tình trạng',
    primary_advisor: lecturers.third,
  },
  {
    title: 'Xây dựng nền tảng mạng xã hội giáo dục',
    description: 'Nền tảng mạng xã hội giáo dục cho cộng đồng giáo dục cho phép người dùng bao gồm người học, người dạy và các trung tâm, tổ chức tạo các trang chia sẻ các kiến thức có đặc trưng về giáo dục, tạo nhóm và sử dụng các công cụ tiện ích phục vụ cho việc giảng dạy',
    primary_advisor: lecturers.fourth,
  },
  {
    title: 'Xây dựng hệ thống cung cấp dịch vụ định danh dựa trên các loại giấy tờ cá nhân phổ biến',
    description: 'Hệ thống cung cấp các dịch vụ (dưới dạng API) cho các người dùng có nhu cầu sử dụng để tích hợp trong hệ thống phát triển của mình về vấn đề nhận dạng các thẻ giấy tờ cá nhân phổ biến như căn cước, passport và các dịch vụ liên quan đến định danh khác mở rộng trên tính năng này. Hệ thống ngoài ra cần quản lý chi phí sử dụng dịch vụ và quản lý người dùng dịch vụ.',
    primary_advisor: lecturers.fifth,
  },
]
topics.each { |topic| Topic.create topic }

# Head of faculty
head_of_faculty = User.create(name: 'PGS. TS. Pham Tran Vu', email: 'faculty@hcmut.edu.vn', password: 'password')
head_of_faculty.add_role :head_of_faculty