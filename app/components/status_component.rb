# frozen_string_literal: true

class StatusComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
    @badge_class = badge_classes[status]
  end

  def badge_classes
    { 'newly_created' => 'bg-dark', 'department_approved' => 'bg-info', 'faculty_approved' => 'bg-success' }
  end
end
