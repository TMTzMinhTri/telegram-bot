module TenantNamespace
  class << self
    def extended(base)
      base.instance_variable_set(:@lock, Mutex.new)
      base.instance_variable_set(:@namespaces, {})
    end
  end

  def current(namespace = nil)
    get(TenantSelect.current, namespace)
  end

  def global(namespace = nil)
    get('_global', namespace)
  end

  def get(tenant, namespace = nil)
    key = "ujet:#{tenant}"
    key += ":#{namespace}" if namespace.present?

    @namespaces[key] || @lock.synchronize { @namespaces[key] = Redis::Namespace.new(key, redis:) }
  end

  def redis
    raise NotImplementedError, "#{self.class.name}##{__method__} is not implemented"
  end
end
