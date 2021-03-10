require_relative '../lib/link_me_bot'
require 'telegram/bot'
require 'json'

describe LinkMeUp do
  json = File.read('./bin/connect_request.json')
  obj = JSON.parse(json)
  data_table = obj['table']

  let(:interest) { data_table[0]['interests'][0] }
  let(:true_message) { Telegram::Bot::Types::Message.new(text: interest) }
  let(:chat_obj) { Telegram::Bot::Types::Chat.new(id: 1_690_066_771) }
  let(:user_obj) { Telegram::Bot::Types::User.new(username: 'mobello19') }
  let(:false_message) { Telegram::Bot::Types::Message.new(text: 'wrestling, boxing', chat: chat_obj, from: user_obj) }
  let(:new_message) { Telegram::Bot::Types::Message.new(text: 'hunting, skydiving', chat: chat_obj, from: user_obj) }
  let(:link_up) { LinkMeUp.new }
  let(:message_text) { 'bitcoin, tech, sports' }

  describe '#ready?' do
    it 'returns a boolean' do
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns true if command is /connect' do
      expect(link_up.ready?('/connect')).to be true
    end

    it 'returns false if command is not /connect' do
      expect(link_up.ready?('/help')).to be false
    end

    it 'returns true if last command is /connect and current interest argument is a non-command string' do
      link_up.ready?('/connect')
      expect(link_up.ready?('football tech')).to be true
    end

    it 'returns false if last command is /connect and current interest argument is a command string' do
      link_up.ready?('/connect')
      expect(link_up.ready?('/football')).to be false
    end
  end

  describe '#formatted_request' do
    it 'returns an array' do
      expect(link_up.formatted_request(message_text)).to be_an Array
    end

    it 'returns array conversion of string argument' do
      expect(link_up.formatted_request(message_text)).to eql(%w[bitcoin tech sports])
    end
  end

  describe '#find_match' do
    context 'when at least one interest match is found' do
      it 'returns an hash' do
        expect(link_up.find_match(true_message)).to be_an Hash
      end

      it 'returns an hash containing an array of matched interests and an hash object of matched user' do
        actual = {
          matched_interests: [interest],
          obj: data_table[0]
        }

        expect(link_up.find_match(true_message)).to eql(actual)
      end

      it 'resets the @ready class variable to false' do
        link_up.find_match(true_message)
        expect(link_up.ready).to be false
      end
    end

    context 'when no interest match is found' do
      it 'returns false' do
        expect(link_up.find_match(false_message)).to be false
      end
    end
  end

  describe '#store_interest' do
    it 'stores username and interests in json file' do
      actual = {
        'chat_id' => new_message.chat.id,
        'username' => new_message.from.username,
        'interests' => link_up.formatted_request(new_message.text)
      }

      link_up.store_interest(new_message)

      json = File.read('./bin/connect_request.json')
      obj = JSON.parse(json)
      data_table = obj['table']

      last_entry = data_table[data_table.length - 1]
      actual = { 'id' => last_entry['id'] }.merge(actual)
      expect(last_entry).to eql(actual)
    end

    it 'resets the @ready class variable to false' do
      link_up.find_match(new_message)
      expect(link_up.ready).to be false
    end
  end
end
