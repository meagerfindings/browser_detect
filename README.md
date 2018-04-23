# Browser Detection with Rails

## ToDo's
 - Tests for views
 - ~~Implement hash ID's rather than sequential ID's for visitor's IDs. [How to Guide](https://hackernoon.com/how-to-use-hash-ids-in-your-url-in-ruby-on-rails-5-e8b7cdd31733) using the [friendly_id gem](https://github.com/norman/friendly_id).~~
    - Primary source for migration to UUIDs: [Migrating to UUIDs as Primary Keys](http://www.madebyloren.com/posts/migrating-to-uuids-as-primary-keys)
    - Source that helped with Migration: [Migrate a Rails application to use UUID with PostgreSQL](http://fidalgo.pt/2017/10/11/uuids_in_rails_with_postgresql.html)
    - Source that helped with `function uuid_generate_v4() does not exist` error during migration:
    [Rails 5.1 + Using a UUID as a primary key in ActiveRecord with PostgreSQL](https://lab.io/articles/2017/04/13/uuids-rails-5-1/)
 - Add third party cookie checker
    - Third party cookies warning for Salesforce or embedded gallery pages
    - This may not be possible without owning two domains. Could I use pilyr? `_napa_tz` [StackOverflow Source](https://stackoverflow.com/questions/3550790/check-if-third-party-cookies-are-enabled)
- Either disable API PUT, POST, DELETE or add API Authentication for these actions.
 - Suggestions logic:
    - Alert on browser versions older than two versions old.
        - ~~Find a dynamic source of truth.~~
        - ~~implementing Browsers > Versions > Issues model instead.~~
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
