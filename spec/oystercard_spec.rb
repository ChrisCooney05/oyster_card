require 'oystercard'

describe Oystercard do
  let(:oystercard) {Oystercard.new}
  it 'Should have an Oystercard class' do
    expect(Oystercard).to respond_to(:new)
  end

  describe '#balance' do
    it 'Should initialize a new a balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'Should top up balance with value passed' do
      oystercard.top_up(20)
      expect(oystercard.balance).to eq(20)
    end

    it 'Should raise an error when new balance will be above 90' do
      expect { oystercard.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::LIMIT}, current balance is £#{@balance.to_i}")
    end
  end

  describe '#deduct' do
    it 'Should deduct from balance with value passed' do
      oystercard.top_up(30)
      expect {oystercard.touch_out}.to change{oystercard.balance}.from(30).to(28)
    end
  end

  describe '#in_journey?' do
    it 'Should return false on a fresh card' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'Should raise an error if balance is below £1 when touching in' do
      expect { oystercard.touch_in }.to raise_error("Insufficient funds, current balance £#{@balance.to_i}. Minimum balance to travel £#{Oystercard::LOW}")
    end

    it 'Should change value of @in_use to true' do
      oystercard.top_up(10)
      oystercard.touch_in
      expect(oystercard.in_use).to eq true
    end
  end

  describe '#touch_out' do
    it 'Should change value of @in_use to false' do
      oystercard.top_up(10)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_use).to eq false
    end
  end
end
