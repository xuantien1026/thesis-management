module Students
  class MyThesesController < BaseController
    def show
      @thesis = ::Theses::Member.find_by(student: current_user)&.thesis
    end
  end
end