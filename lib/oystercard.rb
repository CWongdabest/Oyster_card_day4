class Oystercard
  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up (money)
    fail 'You have exceeded card limit' if exceed_maximum?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail 'insufficient fund' if fund_sufficient?
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def exceed_maximum?(money)
    @balance + money > MAXIMUM_BALANCE
  end

  def fund_sufficient?
    @balance < MINIMUM_BALANCE
  end

  def deduct (amount)
    @balance -= amount
  end

end
