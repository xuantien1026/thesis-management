# frozen_string_literal: true

RSpec.shared_context :signed_in_as_student do
  let(:student) { create :user, :as_student }

  before do
    sign_in student
  end
end

RSpec.shared_context :signed_in_as_lecturer do
  let(:lecturer) { create :user, :as_lecturer }

  before do
    sign_in lecturer
  end
end

RSpec.shared_context :signed_in_as_head_of_department do
  let(:department) { create :department, head: head_of_department }
  let(:head_of_department) { create :user, :as_head_of_department }

  before do
    sign_in head_of_department
  end
end

RSpec.shared_context :signed_in_as_head_of_faculty do
  let(:head_of_faculty) { create :user, :as_head_of_faculty }

  before do
    sign_in head_of_faculty
  end
end
