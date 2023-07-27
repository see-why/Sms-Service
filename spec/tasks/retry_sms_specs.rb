require 'rails_helper'
Rails.application.load_tasks

describe 'rake retry_sms', type: :task do
  let(:set_failed_sms) do
    3.times do
      SmsMessage.create(phone_number: '234-00000', text: 'Batman rocks.', status: 2)
    end
  end

  context 'running task' do
    it 'it calls SmsSenderService' do
      set_failed_sms
      allow_any_instance_of(SmsSenderService).to receive(:make_request).with(an_instance_of(Hash)).and_return({
                                                                                                                status: 'ok', status_code: '200'
                                                                                                              })
      messages_status = SmsMessage.last(3).pluck(:status)
      Rake::Task['retry_sms'].invoke

      expect(messages_status).to eq([2, 2, 2])
    end
  end
end
