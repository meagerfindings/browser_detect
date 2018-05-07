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
- Visitors can create an account to see, edit, and delete previous browser submissions submitted with their email
- Employees can create an account in order to add Browser, Versions, Issues and view and edit the visitor records.

Warns users regarding:
- Adblock
- IE Compatibility Mode
- Currently known issues with user's browser. Checks against internal database for this information.
- When browsers are more than 2 versions out of date.

UUIDs are used for Visitor ID's and User ID's for obscurity and to allow visitors to share their uniquely generated ID with the Support team for reference.

Website name can be set globally through ENV Variable: `COMPANY_WEBSITE_NAME`.

Most CSS provided from [Skeleton CSS](http://getskeleton.com/). 

## TODOs
- ~~Fix double email address showing in `Visitor#show` for employee users.~~
- Real 404 page or redirect to new visitor page
- Switch to SendGrid

### Large TODOs
- JavaScript for making the whole Portal workflow into one screen.
    
---

### Postponed TODOs
- Add third party cookie checker
    - Third party cookies warning for Salesforce or embedded gallery pages
    - This may not be possible without owning two domains. Could I use pilyr? `_napa_tz` [StackOverflow Source](https://stackoverflow.com/questions/3550790/check-if-third-party-cookies-are-enabled)