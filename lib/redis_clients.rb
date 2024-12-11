class RedisClients
  @clients = {}
  @mutex = Mutex.new

  class << self
    def get(url:)
      @clients[url] || @mutex.synchronize { @clients[url] = Redis.new(url:) }
    end
  end
end
