require 'oystercard'

describe Oystercard do
  let(:waterloo) {double :station}
  let(:victoria) {double :station}

  it 'Should have an Oystercard class' do
    expect(Oystercard).to respond_to(:new)
  end

  it 'Should have an empty list of journeys by default' do
    expect(subject.journeys).to eq([])
  end

  describe '#balance' do
    it 'Should initialize a new a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'Should top up balance with value passed' do
      subject.top_up(20)
      expect(subject.balance).to eq(20)
    end

    it 'Should raise an error when new balance will be above 90' do
      expect { subject.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::LIMIT}, current balance is £#{@balance.to_i}")
    end
  end

  describe '#deduct' do
    it 'Should deduct from balance with value passed' do
      subject.top_up(30)
      expect {subject.touch_out(victoria)}.to change{subject.balance}.from(30).to(28)
    end
  end

  describe '#in_journey?' do
    it 'Should return false on a fresh card' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'Should raise an error if balance is below £1 when touching in' do
      expect { subject.touch_in(waterloo) }.to raise_error("Insufficient funds, current balance £#{@balance.to_i}. Minimum balance to travel £#{Oystercard::LOW}")
    end

    it 'Should remember the station that was touched into' do
      subject.top_up(30)
      subject.touch_in(waterloo)
      expect(subject.entry_station).to eq(waterloo)
    end
  end

  describe '#touch_out' do
    it 'Should reset entry station on touch out' do
      subject.top_up(10)
      subject.touch_in(waterloo)
      subject.touch_out(victoria)
      expect(subject.entry_station).to eq(nil)
    end
  end

  describe '#journeys' do
    it 'Should store a list of journeys on #touch_out' do
      subject.top_up(10)
      subject.touch_in(waterloo)
      subject.touch_out(victoria)
      expect(subject.journeys).to include({entry: waterloo, exit: victoria})
    end
  end
end
