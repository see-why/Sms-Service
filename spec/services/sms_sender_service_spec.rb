require 'rails_helper'

describe 'SmsSenderService' do
  describe 'instance methods' do
    subject do
      SmsSenderService.new
    end

    let(:sms) { SmsMessage.create(phone_number: '234-00000', text: 'Batman rocks.') }

    it 'has no notifiers' do
      expect(subject.notifier).to eq(nil)
    end

    it 'has no observers' do
      expect(subject.observers).to eq([])
    end

    it 'has no loggers' do
      expect(subject.logger).to eq(nil)
    end

    it 'can set notifiers' do
      subject.notifier = { stub: 'stub' }
      expect(subject.notifier).to eq({ stub: 'stub' })
    end

    it 'can add observers' do
      subject.add_observer({ stub: 'stub' })
      expect(subject.observers.size).to eq(1)
    end

    it 'can delete observers' do
      subject.remove_observer({ stub: 'stub' })
      expect(subject.observers.size).to eq(0)
    end

    it 'can add loggers' do
      subject.logger = { stub: 'stub' }
      expect(subject.logger).to eq({ stub: 'stub' })
    end

    it 'updates sms status to sent if send successful' do
      allow_any_instance_of(SmsSenderService).to receive(:make_request).with(an_instance_of(Hash)).and_return({
                                                                                                                status: 'ok', status_code: '200'
                                                                                                              })
      subject.send(sms)
      expect(sms.reload.status).to eq(SmsMessage::STATUS_TEXT[:SENT])
    end

    it 'updates sms status to failed if send fails' do
      allow_any_instance_of(SmsSenderService).to receive(:make_request).with(an_instance_of(Hash)).and_return({
                                                                                                                status: 'failed', status_code: '500'
                                                                                                              })
      subject.send(sms)
      expect(sms.reload.status).to eq(SmsMessage::STATUS_TEXT[:FAILED])
    end
  end
end
