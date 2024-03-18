# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  locked_at              :datetime
#  name                   :string           not null
#  phone_number           :string           not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  telegram_sign_in_at    :datetime
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  telegram_chat_id       :string
#  user_id                :integer
#
# Indexes
#
#  index_clients_on_phone_number          (phone_number) UNIQUE
#  index_clients_on_reset_password_token  (reset_password_token) UNIQUE
#  index_clients_on_unlock_token          (unlock_token) UNIQUE
#  index_clients_on_user_id               (user_id)
#
class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :validatable, :Lockable

  validates :phone_number, presence: true, uniqueness: true

  belongs_to :user

  private

  def email_required?
    false
  end
end
