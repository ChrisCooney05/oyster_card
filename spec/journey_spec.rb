require 'journey'
require 'oystercard'

describe Journey do
  it 'Should have an empty list of journeys by default' do
    expect(subject.journeys).to eq([])
  end

  describe '#fare' do
    it 'Should return the min penalty fare' do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
  end
end
