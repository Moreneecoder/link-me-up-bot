require './lib/link_me_bot'
require 'telegram/bot'
require 'json'

describe LinkMeUp do
  json = File.read('./bin/connect_request.json')
  obj = JSON.parse(json)
  data_table = obj['table']

  let(:interest) {data_table[0]['interests'][0]}
  let(:true_message) { Telegram::Bot::Types::Message.new(text: interest) }
  let(:false_message) { Telegram::Bot::Types::Message.new(text: 'hunting') }
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

  describe '#find_match' do
    context 'when at least one interest match is found' do
      it 'returns an hash' do
        expect(link_up.find_match(true_message)).to be_an Hash
      end

      it 'returns an hash containing an array of matched interests and an hash object of matched user' do
        actual = {
          :matched_interests=>[interest],
          :obj=>data_table[0]
        }

        expect(link_up.find_match(true_message)).to eql(actual)
      end
    end

    context 'when no interest match is found' do
      it 'returns a false' do
        expect(link_up.find_match(false_message)).to be false
      end
    end
  end
end
