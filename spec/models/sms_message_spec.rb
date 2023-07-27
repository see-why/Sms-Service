require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  describe 'SmsMessage model validations' do
    subject do
      SmsMessage.new
    end

    before { subject.save }

    it 'text presence' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'phone number presence' do
      subject.phone_number = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'SmsMessage status change method validations' do
    subject do
      SmsMessage.new(phone_number: '234-5624352', text: 'Get a life dude.')
    end

    before { subject.save }

    it 'The sent method updates status to sent' do
      subject.sent
      expect(subject.status).to eq(SmsMessage::STATUS_TEXT[:SENT])
    end

    it 'The failed method updates status to sent' do
      subject.failed
      expect(subject.status).to eq(SmsMessage::STATUS_TEXT[:FAILED])
    end
  end
end
