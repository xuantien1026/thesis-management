RSpec.shared_context :signed_in_as_student do
  let(:student) { create :user }

  before do
    sign_in student
  end
end
