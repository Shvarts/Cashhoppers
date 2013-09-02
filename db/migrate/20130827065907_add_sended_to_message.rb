class AddSendedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sended, :boolean
    Message.all.each do |message|
      message.update_attribute :sended, true
    end
  end
end
