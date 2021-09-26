# frozen_string_literal: true

class ThesisProposalComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(thesis_proposal:, target_status: nil)
    @thesis_proposal = thesis_proposal
    @target_status = target_status
    @tooltip = "<p class='text-left'><b>Mô tả:</b><br>#{thesis_proposal.description}</p>" \
               "<p class='text-left'><b>Nhiệm vụ:</b><br>#{thesis_proposal.mission}</p>"
  end
end
