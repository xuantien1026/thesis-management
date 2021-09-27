module Admin
  class MajorCommitteesController < AdminController
    def show
      @major_committee = MajorCommittee.find(params[:id])
    end
  end
end