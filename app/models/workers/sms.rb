module Worker
  # processes the sms payload from the message queue
  class Sms
    def process(payload)
      phone_number = payload[:phone_number]
      text = payload[:text]

      sms_mesage = SmsMessage.new(phone_number: phone_number, text: text)
      service = SmsSenderService.new # add notifier and logger once implemented
      service.send sms_mesage
    rescue
      # to do: log error using logger
    end
  end
end
