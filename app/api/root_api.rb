# frozen_string_literal: true

require 'grape-swagger'
require 'grape_logging'

class RootApi < Grape::API
  format :json
  prefix :api
  content_type :json, 'application/json'

  # logger.formatter = GrapeLogging::Formatters::Default.new

  # insert_before Grape::Middleware::Error, GrapeLogging::Middleware::RequestLogger,
  #               {
  #                 logger:,
  #                 include: [
  #                   # GrapeLogging::Loggers::Response.new,
  #                   GrapeLogging::Loggers::FilterParameters.new,
  #                   # GrapeLogging::Loggers::ClientEnv.new,
  #                   GrapeLogging::Loggers::RequestHeaders.new
  #                 ],
  #                 log_level: 'debug'
  #               }
  include ExceptionsHandler
  helpers GlobalHelpers

  use GrapeLogging::Middleware::RequestLogger,
      logger:,
      include: [GrapeLogging::Loggers::Response.new,
                GrapeLogging::Loggers::FilterParameters.new,
                # GrapeLogging::Loggers::ClientEnv.new,
                GrapeLogging::Loggers::RequestHeaders.new]
  mount Endpoints::Demo

  add_swagger_documentation(
    base_path: '',
    add_base_path: true,
    add_version: true,
    info: {
      title: 'Weather API',
      contact_url: ''
    },
    array_use_braces: true
  )

  route :any, '*path' do
    error!({ message: 'resource does not exist' }, 404)
  end
end
