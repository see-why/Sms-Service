desc 'retry failed sms'

task :retry_sms do
  SmsMessage.where(status: 2).find_in_batches(batch_size: 100) do |batch|
    batch.each do |message|
      SmsSenderService.new.send message
    end
    # to do: log batch count and time completed
  end
end
