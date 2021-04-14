class LecturerDepartmentComponent < ViewComponent::Base
  def initialize(lecturers:,departments:,department_id:)
    @lecturers = lecturers
    @departments = departments
    @department_id = department_id
  end
end
