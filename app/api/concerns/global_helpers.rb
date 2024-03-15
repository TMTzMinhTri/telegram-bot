# frozen_string_literal: true

module GlobalHelpers
  extend Grape::API::Helpers

  def logger
    RootApi.logger
  end

  def declared_params
    @declared_params ||= ActionController::Parameters.new(declared(
                                                            params,
                                                            include_missing: false
                                                          )).permit!
  end
end
