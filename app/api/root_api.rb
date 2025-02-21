require "grape-swagger"
require "grape_logging"

class RootApi < Grape::API
  format :json
  prefix :api
  content_type :json, "application/json"

  include ExceptionsHandler
  helpers GlobalHelpers

  use GrapeLogging::Middleware::RequestLogger,
      logger:,
      include: [GrapeLogging::Loggers::Response.new,
                GrapeLogging::Loggers::FilterParameters.new,
                GrapeLogging::Loggers::RequestHeaders.new]

  mount Endpoints::Demo

  add_swagger_documentation(
    base_path: "",
    add_base_path: true,
    add_version: true,
    info: {
      title: "Saasgear API",
      contact_url: ""
    },
    array_use_braces: true
  )

  route :any, "*path" do
    error!({ message: "resource does not exist" }, 404)
  end
end
