# frozen_string_literal: true

class StatusComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
    @badge_class = badge_classes[status]
    @status_vn = translation[status]
  end

  private

  def badge_classes
    { 'newly_created' => 'bg-dark', 'department_approved' => 'bg-info', 'faculty_approved' => 'bg-success' }
  end

  def translation
    { 'newly_created' => 'Đang chờ duyệt', 'department_approved' => 'Bộ môn đã duyệt',
      'faculty_approved' => 'Khoa đã duyệt' }
  end
end
