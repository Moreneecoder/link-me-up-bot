require 'telegram/bot'
require './lib/bot_message'

describe BotMessage do
  let(:user_obj) { Telegram::Bot::Types::User.new(username: 'mobello19') }
  let(:message) { Telegram::Bot::Types::Message.new(text: 'hunting, skydiving', from: user_obj) }
  let(:bot_message) {BotMessage.new(message)}
  let(:interests) { ['bitcoin', 'tech', 'sports'] }

  describe '#start_message' do
    it 'returns a string' do
      expect(bot_message.start_message).to be_a String
    end
  end

  describe '#stop_message' do
    it 'returns a string' do
      expect(bot_message.stop_message).to be_a String
    end
  end

  describe '#help_message' do
    it 'returns a string' do
      expect(bot_message.help_message).to be_a String
    end
  end

  describe '#connect_message' do
    it 'returns a string' do
      expect(bot_message.connect_message).to be_a String
    end
  end

  describe '#match_found_message' do
    it 'returns a string' do
      expect(bot_message.match_found_message(interests)).to be_a String
    end

    it 'returns message detailing which matches are found' do
      actual = 'Pssst\\! found you a match for the following interests:  _bitcoin_, _tech_, _sports_,'
      expect(bot_message.match_found_message(interests)).to eql actual
    end
  end

  describe '#match_not_found_message' do
    it 'returns a string' do
      expect(bot_message.match_not_found_message).to be_a String
    end
  end

  describe '#exceeded_message' do
    it 'returns a string' do
      expect(bot_message.exceeded_message).to be_a String
    end
  end
end