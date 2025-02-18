# == Schema Information
#
# Table name: players
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  name                :string
#  phone_number        :string
#  telegram_sign_in_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_players_on_email  (email) UNIQUE
#
class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable
end
