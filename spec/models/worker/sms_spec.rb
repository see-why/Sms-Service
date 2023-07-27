require 'spec_helper'

describe 'Worker::Sms' do
  describe 'Sms worker payload process' do
    subject do
      Worker::Sms.new.process({ phone_number: '1234567', text: 'Happy birthday sup dude.' })
    end

    it 'evokes SmsSenderService' do
      expect_any_instance_of(SmsSenderService).to receive(:send).once
      subject
    end
  end
end
