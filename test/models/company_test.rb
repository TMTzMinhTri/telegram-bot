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
require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
