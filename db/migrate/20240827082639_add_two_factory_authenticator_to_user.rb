class AddTwoFactoryAuthenticatorToUser < ActiveRecord::Migration[7.1]
  def change
    change_table(:users, bulk: true) do |t|
      t.boolean :otp_required_for_login, default: false, null: false
      t.integer :consumed_timestep
      t.string :otp_secret
    end
  end
end
