# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_teams_on_user_id  (user_id)
#
class Team < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'
  has_many :team_members, dependent: :destroy
end
