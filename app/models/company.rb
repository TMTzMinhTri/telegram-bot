# == Schema Information
#
# Table name: public.companies
#
#  id              :bigint           not null, primary key
#  general_setting :jsonb
#  name            :string           not null
#  store_setting   :jsonb
#  sub_domain      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_companies_on_general_setting  (general_setting) USING gin
#  index_companies_on_store_setting    (store_setting) USING gin
#
class Company < ApplicationRecord
  attribute :store_setting, Settings::StoreSetting.to_type
  attribute :general_setting, Settings::GeneralSetting.to_type

  has_many :users, dependent: :destroy
  validates :sub_domain, presence: true
  validates :name, presence: true
  validates :telegram_setting, store_model: true

  after_create :create_tenant
  after_destroy :remove_tenant
  after_save :rename_tenant, if: :sub_domain_previously_changed?

  class << self
    def current
      RequestStore.store[:company]
    end

    def current=(company)
      RequestStore.store[:company] = company
    end

    def fetch(sub_domain, options = {})
      Rails.cache.fetch(cache_key(sub_domain), options) do
        find_by(sub_domain:)
      end
    end

    private

    def cache_key(subdomain)
      "company:#{subdomain}"
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(sub_domain)
  end

  def remove_tenant
    Apartment::Tenant.drop(sub_domain)
  end

  def rename_tenant
    return if sub_domain_previously_was.nil?

    ActiveRecord::Base.connection.execute("ALTER SCHEMA \"#{sub_domain_previously_was}\" RENAME TO \"#{sub_domain}\";")
  end
end
