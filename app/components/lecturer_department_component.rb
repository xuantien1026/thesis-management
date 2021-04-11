class LecturerDepartmentComponent < ViewComponent::Base
  def initialize(lecturer:)
    @lecturer = lecturer
  end
end
