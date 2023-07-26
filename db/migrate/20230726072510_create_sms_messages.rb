class CreateSmsMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :sms_messages do |t|
      t.string :phone_number
      t.text :text
      t.string :status

      t.timestamps
    end
  end
end
