# frozen_string_literal: true

RSpec.shared_context :signed_in_as_student do
  include_context :basic_faculty

  let(:student) { create :student }

  before do
    sign_in student
  end
end

RSpec.shared_context :signed_in_as_lecturer do
  let(:signed_lecturer) { create :lecturer }

  before do
    sign_in signed_lecturer
  end
end

RSpec.shared_context :signed_in_as_head_of_department do
  include_context :basic_faculty

  let(:head_of_department) { create :lecturer, :as_head_of_department, department: current_department }

  before do
    sign_in head_of_department
  end
end

RSpec.shared_context :signed_in_as_head_of_faculty do
  let(:head_of_faculty) { create :lecturer, :as_head_of_faculty }

  before do
    sign_in head_of_faculty
  end
end

RSpec.shared_context :signed_in_as_admin do
  include_context :basic_faculty

  let(:admin) { create :lecturer, :as_admin }

  before do
    sign_in admin
  end
end

# System test
RSpec.shared_context :basic_faculty do
  let!(:current_faculty) { create :faculty }
  let!(:current_department) { create :department, faculty: current_faculty }
  let!(:major) { create :major, faculty: current_faculty }
  let!(:current_semester) { create :semester }
end

RSpec.shared_context :browser_signed_in_as_student do
  let(:student) { create :user, :as_student }

  before do
    login_as student, scope: :user
  end
end

RSpec.shared_context :browser_signed_in_as_lecturer do
  include_context :basic_faculty

  let(:signed_lecturer) { create :lecturer, department: current_department }

  before do
    login_as signed_lecturer, scope: :user
  end
end

RSpec.shared_context :browser_signed_in_as_head_of_department do
  include_context :basic_faculty

  let(:head_of_department) { create :lecturer, :as_head_of_department, department: current_department }

  before do
    login_as head_of_department, scope: :user
  end
end

RSpec.shared_context :browser_signed_in_as_head_of_faculty do
  include_context :basic_faculty

  let(:head_of_faculty) { create :lecturer, :as_head_of_faculty, department: current_department }

  before do
    login_as head_of_faculty, scope: :user
  end
end
