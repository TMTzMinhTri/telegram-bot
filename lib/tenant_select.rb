class TenantSelect
  class << self
    def current
      Company.current.try(:sub_domain)
    end

    def switch(tenant)
      Apartment::Tenant.switch(tenant) do
        Company.current = tenant
      end
    end

    def reset
      Company.current = nil
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
