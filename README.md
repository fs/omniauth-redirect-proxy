# OmniAuth redirect proxy

## Problem

When you need to use OmniAuth with Google on not registered domain in Google
Developer console it's a crap.

For example if you would like to use Heroku review apps each time you need to
register new domain in the Developer Console to let OAuth work.

## Solution

We could use this redirect proxy as a single point for callback which should be registered in Google Developer console.

Redirect proxy will catch up callback request from Google and redirect it back to
application.

The trick is – application domain should be encoded with Base64 in the `state` parameter.

So we will have following flow:

* User clicks on /auth/google_oauth2/?state=http://app-pr-1.herokuapp.com
* App redirects to Google
* User authenticates in Google
* Google redirects to redirect proxy
* Redirect proxy redirects to the http://app-pr-1.herokuapp.com/

## OmniAuth setup

In your app you need setup `OmniAuth.config.full_host` to `http://oauth-redirect-proxy.herokuapp.com`

And encode `request.base_url` with `Base64.encode64` in to `state` parameter.

## Deploy

Just deploy to Heroku as regular Ruby application

```bash
heroku create
git push heroku master
```

## Install

```bash
bin/setup
```

## Quality tools

* `bin/quality` based on [RuboCop](https://github.com/bbatsov/rubocop)
* `.rubocop.yml` describes active checks

## Develop

`bin/build` checks your specs and runs quality tools

## Credits

Ruby Base is maintained by [Timur Vafin](http://github.com/timurvafin).
It was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/ruby-base/contributors).


[<img src="http://www.flatstack.com/logo.svg" width="100"/>](http://www.flatstack.com)
