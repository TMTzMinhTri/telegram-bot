class Redis
  class Tenant
    extend TenantNamespace

    class << self
      def redis
        @redis ||= RedisClients.get(url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' })
      end
    end
  end
end
