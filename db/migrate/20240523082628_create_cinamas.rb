class CreateCinamas < ActiveRecord::Migration[7.1]
  def change
    create_table :cinamas, id: :uuid do |t|
      t.string :sub_domain
      t.string :name
      t.string :address
      t.timestamps
    end
  end
end
