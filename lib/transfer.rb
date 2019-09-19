require 'pry'
class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount, :sender_original_balance, :receiver_original_balance
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @sent_amount = amount
    # @sender_original_balance = @sender.balance
    # @receiver_original_balance = @receiver.balance
  end
  
  def valid?
    @sender.valid? && @receiver.valid?
  end
  
  def execute_transaction
    if @sender.balance < @amount || valid? == false
      @status = "rejected"
      @amount = 0
      "Transaction rejected. Please check your account balance."
    else
      @sender.balance -= @amount
      @receiver.deposit(amount)
      @status = "complete"
      @amount = 0
    end
  end
  
  def reverse_transfer
    @receiver.balance = @receiver_original_balance
    @sender.balance = @sender_original_balance
    @status = "reversed"
  end
  
end
