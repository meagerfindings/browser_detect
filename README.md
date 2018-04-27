# Browser Detection with Rails

## Features:
Detects the following about Visitor's Browsers:
- Adblock Enabled
- Browser & Version
- OS & Version
- IE:
    - Compatibility Mode
- Sends email with visitor's browser information upon submission.  
    - _Email recipient is set by the environment variable:_ `EMAIL_TARGET` 

Warns users regarding:
- Adblock
- IE Compatibility Mode
- Currently known issues with user's browser. Checks against internal database for this information.
- When browsers are more than 2 versions out of date.

UUIDs are used for Visitor ID's for obscurity and to allow users to share their uniquely generated ID with the Support team for reference.

## ToDo's
- Super issue: issue that affects all versions of a portal
    - could I just add Issues to the Portal as well?
- Add option to delete Visitor data from Visitor Show Page
- Add users
    - users can be non employees too, but matching email addresses get employee flag in their account
    - users profile page is surfaces all records that match the email address and allows users to delete them
    - employees get admin access
    - email vaildation necessary for all of the above
- Add authentication
    - Only display email address if authenticated user.
    - Only display visitors' index if authenticated.
    - Only display Edit Visitor link if authenticated.
    - Only allow navigation to Browser and subpages by authenticated users.
- Real 404 page or redirect to new visitor page
- Add styling to site
    - check out [this tutorial](https://www.railstutorial.org/book/rails_flavored_ruby#cha-rails_flavored_ruby)
    - [Ruby on Rails - Layouts](https://www.tutorialspoint.com/ruby-on-rails/rails-layouts.htm)
---

## PostPoned ToDo's
- Add third party cookie checker
    - Third party cookies warning for Salesforce or embedded gallery pages
    - This may not be possible without owning two domains. Could I use pilyr? `_napa_tz` [StackOverflow Source](https://stackoverflow.com/questions/3550790/check-if-third-party-cookies-are-enabled)