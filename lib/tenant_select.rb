class TenantSelect
  class << self
    def current
      Cinama.current.try(:sub_domain)
    end

    def switch(tenant)
      Apartment::Tenant.switch(tenant) do
        Cinama.current = tenant
      end
    end

    def reset
      Cinama.current = nil
      Apartment::Tenant.reset
    end

    def each
      tenants.each do |tenant|
        switch(tenant) { yield(tenant) }
      end
    end

    def tenants
      Apartment.tenant_names
    end
  end
end
