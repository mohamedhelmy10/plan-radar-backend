# Project Setup Guide

## Prerequisites

To run this project, ensure you have the following versions installed:

- **Ruby** version `2.6.7`
- **Rails** version `~> 6.1.7`, `>= 6.1.7.10`
- **PostgreSQL** version `15.3`

### Install the Required Software

1. **Install Ruby:**
   Follow the [official Ruby installation guide](https://www.ruby-lang.org/en/documentation/installation/) to install Ruby version `2.6.7`.

2. **Install Rails:**
   After installing Ruby, you can install Rails by running:
   ```bash
   gem install rails -v '~> 6.1.7'

3. **Install PostgreSQL:**
 	 Follow the [PostgreSQL installation guide](https://www.postgresql.org/download/) to install PostgreSQL version 15.3


## Setup Instructions

Once the required software is installed, follow these steps to get the project up and running.

### Clone the Repository
Clone the repository to your local machine:

git clone https://github.com/mohamedhelmy10/plan-radar-backend.git
cd ticket_reminder_app

### Install Dependencies
Run the following command to install the required gems using Bundler:

bundle install

### Set Up Environment Variables
You need to set the following environment variables for the PostgreSQL database configuration:

DB_NAME=<your_database_name>
DB_USER=<your_database_user>
DB_PASSWORD=<your_database_password>
DB_HOST=<your_database_host>

### Set Up Database
Once the environment variables are set, create the database and run the migrations:

rails db:create
rails db:migrate

This will create the necessary databases for the development and test environments.

### Start the Rails Server
Start the Rails server to run the application locally:

rails server

### Install Redis for Sidekiq
To enable background job processing with Sidekiq, you need to install Redis. Follow the [Redis installation documentation](https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/) to install and start Redis.

Once Redis is installed, you can start the Redis server by running:

redis-server

### Start the Sidekiq Server
Start the Sidekiq worker to process background jobs:

bundle exec sidekiq

### Configure Email Settings
Set the following environment variables for email configuration:

HOST=<your_host_url>
SENDER_EMAIL=<your_sender_email>
EMAIL_PASSWORD=<your_generated_email_password>

Note: To generate the email password, visit your Gmail account, go to Manage Your Google Account > Security > App Passwords, and generate a new app password. Set this password in the EMAIL_PASSWORD variable. For the SENDER_EMAIL, use the Gmail address that you will use as the sender.

### View Sidekiq UI
You can monitor your background jobs through the Sidekiq web UI by visiting:

http://localhost:3000/sidekiq

### Run Spec Files
To run the unit tests locally:
rspec

### Testing the Flow
Once the setup is complete, follow these steps to test the application:

Visit the Users page and create a user with the necessary configuration.
Then, go to the Tickets page, create a new ticket, and assign it to the user you created.
The user should receive an email based on their configurations and time zone.