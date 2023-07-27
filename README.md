# Sms-Service
A service that receives an SMS from a client via a message bus, makes an HTTP request to a 3rd party client and, assuming that HTTP request is successful, publishes an event to a global event bus.

The design is implemented using both the wrapper and observer pattern. The 3rd party client is wrapped by the Sms sender service, the abstraction for the client is the Providable mixin `./app/models/concerns/providable.rb` which when included in a client should implement the `make_request` method. The observer is the abstraction that caters to all the entities that need to know the sms has been sent. In this case an Event Bus. A mixin for the abstraction can be found in `./app/models/concerns/observable.rb`. All entites that wish to observe the sms sent event should include the concern and implement the `event_update` method.

The sms worker `./app/models/workers/sms.rb` should be connected to the queue (message bus), that way when a new sms comes in, it can process the request.

The Sms Send Service `./app/services/sms_sender_service.rb` handles all logic regarding sending the sms and notifying it's observers.
A database model (`./app/models/sms_message.rb`) is used to store each sms request received, while the retry sms rake task (`./lib/tasks`) can be executed to retry failed sms messages.


## Assumptions
- The 3rd party, logger, message queue and event bus details are not known at the time of implementation
- The 3rd party http response contains the following attributes `status` and `status_code`, anything other than `ok` as status is considered a failure
- The 3rd party client is expected to handle phone number verification
- The 3rd party client can handle phone numbers of all countries.
- The message bus knows the maximum number of text that can be sent in each sms

## Trade offs
- The retry sms rake task is not scheduled to run independently.

## Built With
- Ruby version 3.0.3
- RoR version 7.0.6

## Getting Started

**The project comes shipped with linters config for ruby, so ensure you have Rubocop**
**installed in your local development environment**

- **Ensure you have postgresql, ruby and rails set up on your machine**
- **You can change the database adapter in `./config/database.yml` to a more suitable SQL database**
- **Enter database credentials in `./config/database.yml` for each database**
- **To get a local copy of the repository please run the following commands on your terminal:**
- **$ git clone https://github.com/see-why/RailsLedger.git**
- **$ run `bundle install` to couple all dependacies in gem files**
- **$ run `rspec spec` to run all application unit tests**
- **$ run `rails s` to start rails server**
  
## Database creation
Ensure the database service is running then
Run rails db:create db:migrate

👤 **Cyril Iyadi**

- GitHub: [@see-why](https://github.com/see-why)
- LinkedIn: [C.Iyadi](https://www.linkedin.com/in/cyril-iyadi/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments
- my dog Bubbles for the comforting lick here and there
## 📝 License
- This project is [MIT](./LICENSE) licensed.