# frozen_string_literal: true

class StatusComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
    @badge_class = badge_classes[status]
    @status_vn = translation[status]
  end

  private

  def badge_classes
    { 'waiting_for_approval' => 'bg-dark',
      'department_approved' => 'bg-info',
      'major_committee_approved' => 'bg-primary',
      'faculty_approved' => 'bg-success' }
  end

  def translation
    { 'waiting_for_approval' => 'Đang chờ duyệt',
      'department_approved' => 'Bộ môn đã duyệt',
      'major_committee_approved' => 'Hội đồng ngành đã duyệt',
      'faculty_approved' => 'Khoa đã duyệt' }
  end
end
