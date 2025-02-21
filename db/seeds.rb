# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
default_player = ["Yến", "Trí", "Quốc Vinh", "Văn Vinh", "Duy", "Bảo", "Trúc", "Thanh Tâm", "Như Ý", "Thu Minh",
                  "Thuận", "Thịnh"]

default_player.each do |name|
end
