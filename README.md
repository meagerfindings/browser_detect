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
- ~~Add ability to share unique id link with Support team.~~
- ~~switch everything but visitors back to regular ids...~~
- Super issue: issue that affects all versions of a portal
    - could I just add Issues to the Portal as well?
- ~~Disable API PUT, POST, DELETE or add API Authentication for these actions.
    - may want to deprecate API altogether~~
- Add authentication
    - Only display email address if authenticated user.
    - Only display visitors' index if authenticated.
    - Only display Edit Visitor link if authenticated.
    - Only allow navigation to Browser and subpages by authenticated users.
- Add styling to site
    - check out [this tutorial](https://www.railstutorial.org/book/rails_flavored_ruby#cha-rails_flavored_ruby)
    - [Ruby on Rails - Layouts](https://www.tutorialspoint.com/ruby-on-rails/rails-layouts.htm)
---

## PostPoned ToDo's
- ~~Add css checker~~
      - Unable to check CSS on another website. Can't do unless incorporated in the main site:
        ```
        Failed to load https://app.kapost.com/users/sign_in: No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access. If an opaque response serves your needs, set the request's mode to 'no-cors' to fetch the resource with CORS disabled.
        fetch("https://napa-prod-kapost.netdna-ssl
        ```
- ~~CSS false: network blocking or antivirus~~
         - can't create unless added to the main site
- Add third party cookie checker
    - Third party cookies warning for Salesforce or embedded gallery pages
    - This may not be possible without owning two domains. Could I use pilyr? `_napa_tz` [StackOverflow Source](https://stackoverflow.com/questions/3550790/check-if-third-party-cookies-are-enabled)