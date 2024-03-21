# frozen_string_literal: true

module Endpoints
  class Config < RootApi
    resource :config do
      get do
        betting_types = parse_yaml('config/betting_types.yml')
        vendors = parse_yaml('config/vendors.yml')
        present betting_types:, vendors:
      end
    end
  end
end

location = {
  'en': %w[Eng eng],
  'vi': %w[vietnam vn]
}
