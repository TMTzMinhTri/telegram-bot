module Apartment
  module Elevators
    class Generic
      def initialize(app, processor = nil)
        @app = app
        @processor = processor || method(:parse_tenant_name)
      end

      def call(env)
        request = Rack::Request.new(env)
        database = @processor.call(request)

        if database
          switch_tenant(database, env)
        else
          @app.call(env)
        end
      end

      def parse_tenant_name(_request)
        raise 'Override'
      end

      def switch_tenant(name, env)
        Apartment::Tenant.switch(name) do
          cinama = Cinama.fetch(name)
          Cinama.current = cinama
          @app.call(env)
        end
      rescue Apartment::TenantNotFound
        [404, { 'Content-Type' => 'text/json' }, [{ message: 'invalid subdomain' }.to_json]]
      end
    end
  end
end
