module Settings
  class StoreSetting
    include StoreModel::Model
    attribute :allow_client_change_appointment_within, type: :integer, default: 30
    attribute :allow_client_to_select_staff_member, type: :boolean, default: false
    attribute :allow_client_can_book_appointment_within, type: :integer, default: 30

    validates :allow_client_change_appointment_within, numericality: { only_integer: true }
    validates :allow_client_can_book_appointment_within,
              inclusion: { in: [30, 60, 120, 180, 240, 300, 360, 720, 1440, 2080] }

    validate :allow_client_change_appointment_within_range_with_step

    def allow_client_change_appointment_within_range_with_step
      range = (0..2080).step(60)
      return if range.include?(allow_client_change_appointment_within)

      errors.add(:allow_client_change_appointment_within, 'must be a multiple of 60 and within the range 0 to 2080')
    end
  end
end
