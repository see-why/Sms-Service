# send sms using it's notifer object and informs it's observers when successful
class SmsSenderService
  def initialize(observer, notifier = nil, logger = nil)
    @notifier = notifier
    @observer = observer.is_a?(Array) ? observer : [observer]
    @logger = logger
  end

  def add_observer(observer)
    observers << observer
  end

  def remove_observer(observer)
    observers.delete(observer)
  end

  def send(sms_message)
    response = notifier.make_request({ phone_number: sms_message.phone_number, text: sms_message.text })
    if response.status == 'ok'
      notify_observers({ name: :sms_sent, payload: { id: sms_mesage.id } })
      sms_mesage.sent
    else
      logger&.log "sms with id: #{sms_mesage.id}, failed with status code: #{response.status_code}"
      sms_mesage.failed
    end
  rescue => e
    logger&.log "Send attempt failed, error: #{e.message}"
  end

  def notify_observer(event)
    observers.each do |observer|
      observer.event_update event
    end
  end
end
