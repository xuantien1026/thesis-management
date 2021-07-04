# frozen_string_literal: true

module DepartmentManagement
  class DefenseCommitteesController < BaseController
    def index
      @committees = DefenseCommittee.includes(:theses, members: :lecturer).where(department: current_department,
                                                                                 semester: current_semester)
    end

    def create
      @form = DefenseCommitteeForm.new(committee_params)
      if @form.save
        flash[:notice] = 'Đề xuất Hội Đồng Bảo Vệ thành công'
        redirect_to dept_defense_committees_path
      else
        flash[:alert] = @form.errors.full_messages
        render :suggest
      end
    end

    def suggest
      @thesis_groups = current_department.lecturers.index_with { |lecturer| Thesis.by_lecturer(lecturer) }
    end

    def new
      @form = DefenseCommitteeForm.new(suggest_committee_params)
      @lecturers = Lecturer.where(department: current_department).pluck(:name, :id)
    end

    private

    def suggest_committee_params # rubocop:disable Metrics/MethodLength
      attributes = group_theses_by_committee.map do |thesis_ids|
        lecturer_ids = ::Theses::Advisor.where(primary: true, thesis_id: thesis_ids).pluck(:lecturer_id).uniq

        {
          department_id: current_department.id,
          semester_id: current_semester.id,
          thesis_ids: thesis_ids,
          lecturer_ids: lecturer_ids
        }
      end
      {
        defense_committees_attributes: (1..attributes.count).zip(attributes).to_h
      }
    end

    def group_theses_by_committee
      committees = Hash.new { |hash, key| hash[key] = [] }
      suggest_params.each_with_object(committees) do |(thesis_id, committee_number), memo|
        memo[committee_number] << thesis_id
      end
      committees.values
    end

    def suggest_params
      params.require(:thesis_group).permit!.to_h
    end

    def committee_params
      params.require(:defense_committee_form)
            .permit(defense_committees_attributes: [
                      :department_id, :semester_id,
                      { members_attributes: %i[lecturer_id role], thesis_ids: [] }
                    ])
    end
  end
end
