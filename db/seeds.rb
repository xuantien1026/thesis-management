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

# Department
department_heads = [
  { name: 'PGS.TS. Huynh Tuong Nguyen', email: 'huynhtuongnguyen@hcmut.edu.vn', password: 'password' },
  { name: 'TS. Nguyen Duc Thai', email: 'nguyenducthai@hcmut.edu.vn', password: 'password' },
  { name: 'PGS.TS Tran Minh Quang', email: 'tranminhquang@hcmut.edu.vn', password: 'password' },
  { name: 'TS. Truong Tuan Anh', email: 'truongtuananh@hcmut.edu.vn', password: 'password' },
  { name: 'PGS.TS Pham Quoc Cuong', email: 'phamquoccuong@hcmut.edu.vn', password: 'password' },
]
departments = [
  { name: 'Department of Computer Science', program: 'CS' },
  { name: 'Department of System and Networking', program: 'CS' },
  { name: 'Department of Information System', program: 'CS' },
  { name: 'Department of Software Engineering', program: 'CS' },
  { name: 'Department of Computer Engineering', program: 'CE' },
]
5.times do |index|
  dept_head = User.create department_heads[index]
  dept_head.add_role :head_of_department

  dept = Department.create departments[index].merge(head: dept_head)
end

# Lecturers
lecturers = [
  { name: 'TS. Le Hong Trang', email: 'lehongtrang@hcmut.edu.vn', password: 'password', department_id: 1 },
  { name: 'TS. Nguyen An Khuong', email: 'nguyenankhuong@hcmut.edu.vn', password: 'password', department_id: 1 },

  { name: 'TS. Nguyen Le Duy Lai', email: 'nguyenleduylai@hcmut.edu.vn', password: 'password', department_id: 2 },
  { name: 'TS. Nguyen Quang Hung', email: 'nguyenquanghung@hcmut.edu.vn', password: 'password', department_id: 2 },

  { name: 'PGS.TS. Nguyen Thanh Binh', email: 'nguyenthanhbinh@hcmut.edu.vn', password: 'password', department_id: 3 },
  { name: 'PGS.TS. Dang Tran Khanh', email: 'dangtrankhanh@hcmut.edu.vn', password: 'password', department_id: 3 },

  { name: 'PGS.TS. Quan Thanh Tho', email: 'quanthanhtho@hcmut.edu.vn', password: 'password', department_id: 4 },
  { name: 'TS. Nguyen Van Hiep', email: 'nguyenvanhiep@hcmut.edu.vn', password: 'password', department_id: 4 },

  { name: 'TS. Pham Hoai Anh', email: 'phamhoaianh@hcmut.edu.vn', password: 'password', department_id: 5 },
  { name: 'TS. Le Trong Nhan', email: 'letrongnhan@hcmut.edu.vn', password: 'password', department_id: 5 },
]
lecturers.each { |lecturer| l = User.create(lecturer); l.add_role :lecturer }


# Lecturers & their topics
lecturers = User.with_role :lecturer

topics = [
  {
    title: 'Xây dựng hệ thống trao đổi phiếu mua hàng',
    description: 'Tìm hiểu, phân tích và xây dựng các hệ thống trao đổi, kinh doanh phiếu mua hàng.',
    primary_advisor: lecturers.first,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng hệ thống quản lý luận văn tốt nghiệp tại khoa Khoa học và KTMT Trường Đại học Bách khoa TP.HCM',
    description: 'Phân tích, thiết kế và xây dựng hệ thống quản lý luận văn tốt nghiệp cho khoa CSE, HCMUT',
    primary_advisor: lecturers.first,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng nền tảng quản lý, cấp phát và sử dụng tài sản/thiết bị',
    description: 'Nền tảng cho phép các tổ chức quản lý tài sản, thiết bị, cấp phát và sử dụng tài sản thiết bị cho các thành viên trong tổ chức, tracking quá trình sử dụng, thời lượng được cấp phát sử dụng, và tình trạng',
    primary_advisor: lecturers.second,
    program: 'CS_CE',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng nền tảng mạng xã hội giáo dục',
    description: 'Nền tảng mạng xã hội giáo dục cho cộng đồng giáo dục cho phép người dùng bao gồm người học, người dạy và các trung tâm, tổ chức tạo các trang chia sẻ các kiến thức có đặc trưng về giáo dục, tạo nhóm và sử dụng các công cụ tiện ích phục vụ cho việc giảng dạy',
    primary_advisor: lecturers.second,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng hệ thống cung cấp dịch vụ định danh dựa trên các loại giấy tờ cá nhân phổ biến',
    description: 'Hệ thống cung cấp các dịch vụ (dưới dạng API) cho các người dùng có nhu cầu sử dụng để tích hợp trong hệ thống phát triển của mình về vấn đề nhận dạng các thẻ giấy tờ cá nhân phổ biến như căn cước, passport và các dịch vụ liên quan đến định danh khác mở rộng trên tính năng này. Hệ thống ngoài ra cần quản lý chi phí sử dụng dịch vụ và quản lý người dùng dịch vụ.',
    primary_advisor: lecturers.third,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng hệ thống Blog chia sẻ kiến thức về công nghệ trên nền tảng IPFS',
    description: 'Tìm hiểu và triển khai nền tảng công nghệ web phân tán (IPFS)
Xây dựng một hệ thống hỗ trợ người dùng viết và chia sẻ kiến thức về công nghệ
Hệ thống sẽ tham khảo 1 số tính năng của các trang blog nổi tiếng như medium, hackernoon,...
Hệ thống cho phép người dùng viết và chia sẻ những kiến thức của họ. Các bài viết được đăng và duyệt theo các quy trình được định nghĩa trước, hoặc được thực hiện một cách tự động.
Hệ thống có chức năng đánh giá như like, share, comment, xếp hạng các bài viết.
Ngoài ra hệ thống còn có các tính năng khác như tạo chủ đề, bảng xếp hạng, xu hướng, phân loại
',
    primary_advisor: lecturers.third,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng hệ thống nhận diện mức độ tập trung của sinh viên trong giờ học bằng xử lý ảnh.',
    description: 'Phân tích, thiết kế và xây dựng hệ thống cho phép phân tích khả năng tập trung của sinh viên trong giờ học bằng thị giác máy tính (xử lý ảnh)
Thiết kế bộ lưu trữ, tổ chức dữ liệu hình ảnh, video, và kết quả phân tích
Hỗ trợ giáo vụ trong việc đánh giá các phương pháp giảng dạy, nội dung môn học, chương trình đào tạo nhằm nâng cao độ tập trung của sinh viên
Hỗ trợ phòng kiểm định chất lượng nhằm đánh giá khách quan từ nhiều phía (kết quả phân tích từ hệ thống, kết quả đánh giá từ sinh viên)
Tích hợp hệ thống, phân tích và đánh giá các giải pháp đề xuất.
Demo chức năng cơ bản.
',
    primary_advisor: lecturers.fourth,
    program: 'CS',
    number_of_students: 2,
  },
  {
    title: 'Xây dựng hệ thống quản lý kho hàng cho một doanh nghiệp',
    description: 'Một doanh nghiệp thương mại có thể có nhiều kho chứa hàng. Hàng hóa xuất và nhập ra vào kho liên tục. Quá trình xuất nhập kho sẽ do người thủ kho quản lý. Hàng hóa nhập kho cần ghi rõ loại hàng, số lượng và một số chi tiết cụ thể của từng loại hàng. Hàng xuất kho cũng phải có thông tin tương tự, bên cạnh lý do xuất kho. Lý do xuất kho có thể là để bán hoặc chuyển sang kho khác. Hệ thống xây dựng cần quản lý quy trình này.',
    primary_advisor: lecturers.fourth,
    program: 'CS',
    number_of_students: 2,
  },
]
topics.each { |topic| Topic.create topic }

# Head of faculty
head_of_faculty = User.create(name: 'PGS. TS. Pham Tran Vu', email: 'phamtranvu@hcmut.edu.vn', password: 'password')
head_of_faculty.add_role :head_of_faculty