require './lib/link_me_bot'

describe LinkMeUp do
  let(:link_up) { LinkMeUp.new }
  let(:message_text) {'bitcoin, tech, sports'}

  describe '#ready?' do
    it 'returns a boolean' do
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns true if argument is /connect' do
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns false if argument is not /connect' do
      expect(link_up.ready?('/help')).to be false
    end

    it 'returns true if last command is /connect and current argument is a non-command string' do
      link_up.ready?('/connect')
      expect(link_up.ready?('football tech')).to be true
    end
  end

  describe '#formatted_request' do
    it 'returns an array' do
      expect(link_up.formatted_request(message_text)).to be_an Array
    end

    it 'returns array conversion of string argument' do
      expect(link_up.formatted_request(message_text)).to eql(['bitcoin', 'tech', 'sports'])
    end
  end
end
