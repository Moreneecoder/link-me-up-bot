require_relative '../lib/bot_client'
require_relative '../lib/bot_message'
require 'telegram/bot'
require 'dotenv'
Dotenv.load('./.env')

describe BotClient do
  let(:bot_client) { BotClient.new }

  describe '#initialize' do
    it 'activates the bot client using correct token' do
      expect(bot_client.token).not_to eql ''
    end
  end
end
