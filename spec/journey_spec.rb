require 'journey'

describe Journey do
  it 'Should have an empty list of journeys by default' do
    expect(subject.journeys).to eq([])
  end
end
