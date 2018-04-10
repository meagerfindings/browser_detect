# Browser Detection with Rails

## ToDo's
 - add data validation
 - add unit tests
    - Controllers
        - Visitor
            - ~~update~~
            - ~~destroy~~
    - Views
        - Edit
    - API
        - GET
        - POST
        - PUT
        - DESTROY
 - Implement hash ID's rather than sequential ID's for visitior's IDs. [How to Guide](https://hackernoon.com/how-to-use-hash-ids-in-your-url-in-ruby-on-rails-5-e8b7cdd31733) using the [friendly_id gem](https://github.com/norman/friendly_id).
 - Add css checker
 - Add AdBlock checker: [StackOverflow source](https://stackoverflow.com/a/20505898)
 - Add third party cookie checker
 - detect browser plugins???
    - Add API to receive request from client. Check out this guide: [Build an API in your Rails app now!](https://www.kollegorna.se/en/2015/04/build-an-api-now/)
 - Suggestions logic:
    - CSS false: network blocking or antivirus
    - adlbocker detection: suggest disabling or whitelisting
    - Alert on IE:
        - for known issues
            - compatibility mode
    - Third party cookies warning for Salesforce or embedded gallery pages

---
    
## Mentor Questions:

- ~~Ask Charlie about sending client-side data (JS) to server-side (Rails).~~
