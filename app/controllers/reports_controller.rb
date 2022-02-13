# frozen_string_literal: true

class ReportsController < ApplicationController
  def show
    @committee = DefenseCommittee.find(params[:defense_committee_id])
    respond_to do |format|
      format.pdf do
        render pdf: 'bien_ban_hoi_dong_lvtn', margin: { top: 15, bottom: 15, left: 15, right: 15 },
               show_as_html: params.key?('debug')
      end
    end
  end
end
