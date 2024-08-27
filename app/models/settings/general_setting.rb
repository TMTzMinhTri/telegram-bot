module Settings
  class GeneralSetting
    include StoreModel::Model
    enum :turn_option, {
      turn_by_ticket: 0,
      fixed_turn_by_service: 1,
      turn_by_service_number: 2,
      turn_by_service_account: 3
    }, default: :turn_by_ticket

    attribute :min_turn_in_dollar, type: :integer, default: 10
    attribute :dollars_for_a_reward_point, type: :integer, default: 1
    attribute :tax, type: :integer, default: 0
    attribute :amount_haft_turn, type: :integer, default: 0
    attribute :redeem_reward_points_for_a_dollar, type: :integer, default: 0
    attribute :is_early_check_in_reward, type: :boolean, default: false
    attribute :early_check_in_reward, type: :integer, default: 0

    validates :min_turn_in_dollar, numericality: { only_integer: true }
    validates :dollars_for_a_reward_point, numericality: true
    validates :early_check_in_reward, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
    validates :tax, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

    validate :min_turn_in_dollar_in_range_with_step

    def min_turn_in_dollar_in_range_with_step
      range = (10..40).step(5)
      return if range.include?(min_turn_in_dollar)

      errors.add(:min_turn_in_dollar, 'must be an integer between 10 and 40, and in steps of 5')
    end
  end
end
