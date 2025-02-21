# frozen_string_literal: true

module GlobalHelpers
  extend Grape::API::Helpers

  delegate :logger, to: :RootApi

  def authenticate_user!
    error!("401 Forbidden", 401) unless current_user
  end

  def current_user
    @current_user ||= warden.authenticate(scope: :user)
  end

  def declared_params
    @declared_params ||= ActionController::Parameters.new(declared(params, include_missing: false)).permit!
  end

  def parse_yaml(file)
    YAML.load(File.open(file))
  end

  private

  def warden
    env["warden"]
  end
end
