require './lib/link_me_bot'

describe LinkMeUp do
  describe '#ready?' do
    it 'returns a boolean' do
      link_up = LinkMeUp.new
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns true if argument is /connect' do
      link_up = LinkMeUp.new
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns false if argument is not /connect' do
        link_up = LinkMeUp.new
        expect(link_up.ready?('/help')).to be false
    end

    it 'returns true if last command is /connect and current argument is a non-command string' do
        link_up = LinkMeUp.new
        link_up.ready?('/connect')
        expect(link_up.ready?('football tech')).to be true
    end
  end
end