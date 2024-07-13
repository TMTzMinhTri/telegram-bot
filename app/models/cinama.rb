# == Schema Information
#
# Table name: public.cinamas
#
#  id             :uuid             not null, primary key
#  address        :string
#  name           :string
#  sub_domain     :string
#  theaters_count :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Cinama < ApplicationRecord
  has_paper_trail
  validates :sub_domain, presence: true
  validates :name, presence: true

  has_many :theaters, dependent: :destroy
  after_create :create_tenant
  after_destroy :remove_tenant

  after_save :rename_tenant, if: :sub_domain_previously_changed?

  class << self
    def current
      RequestStore.store[:cinama]
    end

    def current=(cinama)
      RequestStore.store[:cinama] = cinama
    end

    def fetch(sub_domain, options = {})
      Rails.cache.fetch(cache_key(sub_domain), options) do
        find_by(sub_domain:)
      end
    end

    private

    def cache_key(subdomain)
      "cinama:#{subdomain}"
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
