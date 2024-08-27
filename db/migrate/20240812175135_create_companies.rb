class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :sub_domain
      t.jsonb :store_setting, index: { using: :gin }, default: {}
      t.jsonb :general_setting, index: { using: :gin }, default: {}

      t.timestamps
    end
  end
end
