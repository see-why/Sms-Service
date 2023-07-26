# base functionality for sms event observers
module Observable
  extend ActiveSupport::Concern

  def event_update(event); end
end
