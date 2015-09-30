require 'spec_helper'

describe SpicedGracken::Message::NodeListHash do
  let(:klass) { SpicedGracken::Message::NodeListHash }

  before(:each) do
    mock_settings_objects
  end

  context 'instantiation' do
    it 'sets a default payload' do
      msg = klass.new
      expect(msg.payload).to_not be_nil
    end
  end

  context 'display' do
    it 'displays hash' do
      msg = klass.new(message: 'hash')

      expect(msg.display).to include('hash')
    end
  end

  context 'respond' do
    it 'shoots off a ping reply to the sender of the ping' do
      expect(SpicedGracken::Http::Client).to receive(:send_to_and_close)

      msg = klass.new(message: 'hash')
      msg.respond
    end
  end
end