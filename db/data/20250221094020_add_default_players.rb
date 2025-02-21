# frozen_string_literal: true

class AddDefaultPlayers < ActiveRecord::Migration[7.2]
  def up
    default_player = ["Yến", "Trí", "Quốc Vinh", "Văn Vinh", "Duy", "Bảo", "Trúc", "Thanh Tâm", "Như Ý", "Thu Minh",
                      "Thuận", "Thịnh"]
    Player.insert_all(default_player.map { |name| { name: name, email: "#{name.parameterize}@temp.com" } }) # rubocop:disable Rails/SkipsModelValidations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
