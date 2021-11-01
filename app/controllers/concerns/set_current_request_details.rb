module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.semester = Semester.order(:start_date).last
    end
  end
end
