module CommitteeHelper
  def committee_session_status_bagde(committee)
    tag.span(class: "badge #{badge_type(committee)}") { committee.session }
  end

  def badge_type(committee)
    badge_types = { 'inactive' => 'bg-secondary text-dark', 'active' => 'bg-primary text-light ',
                    'completed' => 'bg-success text-light ' }
    badge_types[committee.session]
  end
end