class CreateTheaters < ActiveRecord::Migration[7.1]
  def change
    create_table :theaters do |t|
      t.references :cinama, type: :uuid
      t.string :name, null: false
      t.integer :seats_count, default: 0
      t.integer :seats_count_available, default: 0
      t.jsonb :seating_layouts, default: {}
      t.index :seating_layouts, using: :gin
      t.index %i[name cinama_id], unique: true
      t.timestamps
    end
    add_column :cinamas, :theaters_count, :integer, default: 0
  end
end
