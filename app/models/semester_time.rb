# == Schema Information
#
# Table name: semester_times
#
#  id              :bigint           not null, primary key
#  school_year     :integer
#  semester_number :integer
#  start_date      :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class SemesterTime < ApplicationRecord
end
