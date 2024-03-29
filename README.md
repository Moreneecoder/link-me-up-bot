# link-me-up-bot
> This project is a Telegram bot that connects people via their DM based on their interests. Built with Ruby and the telegram-bot-ruby library.

![](https://user-images.githubusercontent.com/38987207/110521212-c08eab00-810f-11eb-8d65-0deb57efd5f9.png)

## About The Program
The LinkMeUp bot is a mini social networking system built ontop of the Telegram Bot api. It helps people connect with other private users who actively shares their current interests. A user asks the bot to search for another user who shares the similar sets of interests with them and if the bot finds a match, it instantly  automatically exchange their chat links/usernames.

## Built With

- Ruby programming language
- [Telegram-Bot-Ruby](https://github.com/atipugin/telegram-bot-ruby) library
- RSpec
- ActiveRecord Gem
- Sinatra
- PostgreSQL

## Getting Started

To set up a local version of this project, a collection of steps have been put together to help guide you from installations to usage. Simply follow the guide below and you'll be up and running in no time.

### Set up

- Install [git](https://git-scm.com/downloads)
- Install [the Ruby programming language](https://ruby-doc.org/downloads/), if you haven't already.
- Open Terminal
- Navigate to the preferred location/folder you want the app on your local machine. Use `cd <file-path>` for this.
- Run `git clone https://github.com/Moreneecoder/link-me-up-bot.git` to download the bot source file.
- Now that you have a local copy of the project, navigate to the root of the project folder from your terminal.

- Run `bundle install` to install all dependencies in the Gemfile file.
- Run `rake db:create` to create the database.
- Run `rake db:migrate` to migrate/create database tables.
- Alternatively, you can `run rake db:reset` to drop database, recreate the database and then recreate the tables in one command.

> You need to have PostgreSQL installed on your machine for your database actions to work. If you don't know how, you can do so [here](https://www.freecodecamp.org/news/how-to-get-started-with-postgresql-9d3bc1dd1b11/)

- One last **important** detail. To control your bot uniquely, you will need a Telegram Bot Api *token* from the [Botfather](https://core.telegram.org/bots#6-botfather)
- When you get your api token from Botfather, open the `bot_client.rb` file and replace the value of the token class variable with your new token. The current value of the token variable should be `ENV['BOT_API_KEY']`. Or alternatively, you could create a `.env` file and put the token in there.

### Other Dependencies

- Rubocop: This is a tool for checking code quality and ensuring they meet the requirements. Don’t worry about this if you’re not a developer. Microverse provides a wonderful setup guide for [rubocop here](https://github.com/microverseinc/linters-config/tree/master/ruby).

- RSpec: This is a tool for testing the effectiveness of the program's logic at every step. Again, don’t worry about this if you’re not a developer. To set up RSpec:
  - run `gem install rspec` in your terminal. This should install rspec globally on your local machine.
  - run `rspec --version`. This should display your rspec version if successfully installed.
  - run `rspec` to see passing and failing tests.

### Usage

At this point, you now have everything you need to properly run the program (source code, ruby, rspec, rubocop, api token). If not, refer back to the setup section of this documentation.

To get the bot running, follow the instructions below:

* run `bin/main.rb` in the terminal. You should make sure your terminal is navigated to the current directory of the program. Now you should see a message that says **Bot is running...**

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

* If a match is not found instantly, the program will store your interests in the database.
* When a new connection request that matches your interest comes along, you will get their chat link and they will get yours.

![](https://user-images.githubusercontent.com/38987207/110536384-b07fc700-8121-11eb-929a-ac7c51755abb.png) 

* That's it! Have fun!

## Author

👤 **Morenikeji Fuad Bello**

- GitHub: [@Moreneecoder](https://github.com/Moreneecoder)
- Twitter - [@mo_bello19](https://twitter.com/mo_bello19)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Moreneecoder/link-me-up-bot/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- [Micoverse](https://microverse.org) for the rubocop setup link

## 📝 License

This project is [MIT](https://github.com/Moreneecoder/link-me-up-bot/blob/feature/app_logic/LICENSE) licensed.
