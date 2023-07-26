# database model representing sms messages
class SmsMessage < ApplicationRecord
  validates :phone_number, presence: true
  validates :text, presence: true

  STATUS_TEXT = { PROCESSING: 0, SENT: 1, FAILED: 2 }.freeze

  attribute :status, :integer, default: STATUS_TEXT[:PROCESSING]

  def sent
    update(status: STATUS_TEXT[:SENT])
    save
  end

  def failed
    update(status: STATUS_TEXT[:FAILED])
    save
  end
end
