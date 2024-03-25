# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  created_by :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_created_by  (created_by)
#
class Team < ApplicationRecord
  belongs_to :created_by,
             class_name: 'User',
             foreign_key: :created_by,
             inverse_of: 'team'
  has_many :team_members, dependent: :destroy
end
