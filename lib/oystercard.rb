class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  EMPTY_JOURNEY = []

  def initialize(balance = DEFAULT_BALANCE, journey = EMPTY_JOURNEY)
    @balance = balance
    @journey = []
    @this_journey = {}
  end

  def top_up (money)
    fail 'You have exceeded card limit' if exceed_maximum?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail 'insufficient fund' if fund_sufficient?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    record_journey
    @entry_station = nil
    @exit_station
  end

  def in_journey?
    !!@entry_station
  end

  def record_journey
    @this_journey[:entry] = entry_station
    @this_journey[:exit] = exit_station
    @journey << @this_journey
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
