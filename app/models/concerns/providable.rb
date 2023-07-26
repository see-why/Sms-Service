# base functionality for sms providers
module Providable
  extend ActiveSupport::Concern

  def make_request; end
end
