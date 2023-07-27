# send sms using it's notifer object and informs it's observers when successful
class SmsSenderService
  attr_accessor :notifier, :logger
  attr_reader :observers

  def initialize(observer = [], notifier = nil, logger = nil)
    @notifier = notifier
    @observers = observer.is_a?(Array) ? observer : [observer]
    @logger = logger
  end

  def add_observer(observer)
    observers << observer
  end

  def remove_observer(observer)
    observers.delete(observer)
  end

  def send(sms_message)
    response = make_request({ phone_number: sms_message.phone_number, text: sms_message.text })
    if response[:status] == 'ok'
      sms_message.sent
      notify_observers({ name: :sms_sent, payload: { id: sms_mesage.id } })
    else
      sms_message.failed
      logger&.log "sms with id: #{sms_mesage.id}, failed with status code: #{response[:status_code]}"
    end
  rescue => e
    logger&.log "Send attempt failed, error: #{e.message}"
  end

  def notify_observer(event)
    observers.each do |observer|
      observer.event_update event
    end
  end

  def make_request(body)
    notifier.make_request(body)
  end
end
