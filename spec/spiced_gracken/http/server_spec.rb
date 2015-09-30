
require 'spec_helper'

describe SpicedGracken::Http::Server do
  let(:klass) { SpicedGracken::Http::Server }

  before(:each) do
    mock_settings_objects
  end

  describe '#processes_message' do
    before(:each) do
      allow_any_instance_of(klass).to receive(:listen){}
    end

    it 'whisper' do
      json = '{
        "type":"whisper",
        "message":"yo",
        "client":"Spiced Gracken",
        "client_version":"0.1.2",
        "time_sent":"2015-09-30 09:04:59 -0400",
        "sender":{
          "name":"nvp",
          "location":"localhost:8081",
          "uid":"1"
        }
      }'
      json = JSON.parse(json)

      s = klass.new
      msg = s.processes_message(json)
      expect(msg.display).to include("nvp")
      expect(msg.display).to include("yo")
    end
  end

end