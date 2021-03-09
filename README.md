# link-me-up-bot
> This project is a Telegram bot that connects people via their DM based on their interests. Built with Ruby and the telegram-bot-ruby library.

![](https://user-images.githubusercontent.com/38987207/110521212-c08eab00-810f-11eb-8d65-0deb57efd5f9.png)

## About The Program
The LinkMeUp bot is a mini social networking system built ontop of the Telegram Bot api. It helps people connect with other private users who actively shares their current interests. A user asks the bot to search for another user who shares the similar sets of interests with them and if the bot finds a match, it instantly  automatically exchange their chat links/usernames.

## Built With

- Ruby programming language
- [Telegram-Bot-Ruby](https://github.com/atipugin/telegram-bot-ruby) library
- RSpec

## Getting Started

To set up a local version of this project, a collection of steps have been put together to help guide you from installations to usage. Simply follow the guide below and you'll be up and running in no time.

### Set up

- Install [git](https://git-scm.com/downloads)
- Install [the Ruby programming language](https://ruby-doc.org/downloads/), if you haven't already.
- Open Terminal
- Navigate to the preferred location/folder you want the game on your local machine. Use `cd <file-path>` for this.
- Run `git clone https://github.com/Moreneecoder/link-me-bot.git` to download the game source file.
- Now that you have a local copy of the project, navigate to the root of the project folder from your terminal.
- Run `bundle install` to install all dependencies in the Gemfile file.
- One last **important** detail. To control your bot uniquely, you will need a Telegram Bot Api *token* from the [Botfather](https://core.telegram.org/bots#6-botfather)

### Other Dependencies

- Rubocop: This is a tool for checking code quality and ensuring they meet the requirements. Don’t worry about this if you’re not a developer. Microverse provides a wonderful setup guide for [rubocop here](https://github.com/microverseinc/linters-config/tree/master/ruby).

- RSpec: This is a tool for testing the effectiveness of the program's logic at every step. Again, don’t worry about this if you’re not a developer. To set up RSpec:
  - run `gem install rspec` in your terminal. This should install rspec globally on your local machine.
  - run `rspec --version`. This should display your rspec version if successfully installed.
  - run `rspec` to see passing and failing tests.

### Usage

At this point, you now have everything you need to properly run the program (source code, ruby, rspec, rubocop, api token). If not, refer back to the setup section of this documentation.

To get the bot running, follow the instructions below:

* run `bin/bot_init.rb` in the terminal. You should make sure your terminal is navigated to the current directory of the program. Now you should see a message that says **Bot is running...**

![](https://user-images.githubusercontent.com/38987207/110529160-30556380-8119-11eb-8bb6-a540988730c7.png)

* Open your newly created bot in telegram and send ***/help*** as shown in the image below.
* You should get a response from the bot with a short list of commands

![](https://user-images.githubusercontent.com/38987207/110531033-609e0180-811b-11eb-9366-ea6ce65106b3.png)

* Send ***/connect*** to the bot to request a new connection based on your interests.
* The bot should now give you a short important note on how to format your interests.

![](https://user-images.githubusercontent.com/38987207/110531861-647e5380-811c-11eb-95d5-0a3b551ed797.png)

> **NOTE**: The ***/connect*** command is what tells the bot you want to enter new interests. You have to enter it anytime you want request a new connection by new interests.

* Now, enter your interests (a maximum of five) and send to the bot.
* If at least a match is found with one of your interests, the bot should send you the telegram chat link of the matched user. It will also send them your chat link. See reference in the image below:

![](https://user-images.githubusercontent.com/38987207/110533927-c8a21700-811e-11eb-81aa-46d544874330.png)

* If a match is not found instantly, the program will store your interest in the connect_request.json file.
* When a new connection request that matches your interest comes along, you will get their chat link and they will get yours.

![](https://user-images.githubusercontent.com/38987207/110536384-b07fc700-8121-11eb-929a-ac7c51755abb.png)

* That's it! Have fun!
