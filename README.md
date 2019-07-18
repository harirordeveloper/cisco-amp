# README
This Project is built on Rails 6

As part of this project conatains following things

1. It has role based login system
2. It has integrated CISCO AMP API to fetch the computres and their users information.
3. I have added Friendly Id to hide the Real computer record ID's in the URL.
4. I have added Sidekiq configuration to trigger the rake tasks to update DB data from API calls.
5. I have written some few cucumber specs to test login and signup functionality ( couldn't cover more because of time constraint)
6. Admin sets the API credentials in dashboard at "services" section.



The way to test this app is

1 . Create an admin using the admin mail ID and password

2. After successfully logging in with Admin credentials need to set the API credentials in services section.

3. Now register a general user with a username in the user activity records so that you can get the activity of that user.

4. Now as the scheduler is configured it will autorun the rake tasks to populate the data from API to DB.

5. Finally you should see the data populated.