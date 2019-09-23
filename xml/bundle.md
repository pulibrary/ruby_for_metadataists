# Managing Dependencies with Bundler

The most common way to share Ruby code is to package modules as Ruby Gems, available from
[RubyGems.org](https://rubygems.org/).  Intead of downloading and installing individual
Gems, we generally use Bundler to manage installing Gems and any Gems they depend on.

One nice feature of Gems and Bundler is the ability to install them in a local directory.
This has two key advantages:
1. You generally do not need administrator privileges to install Gems.
2. Each application can have its own set of dependencies installed within its working
   directory, avoiding version conflicts between different applications.

## Install the Bundler Gem
```
gem install -i vendor/bundle bundler
```

## Use Bundler to Install Other Dependencies
```
vendor/bundle/bin/bundle install --path vendor/bundle
```

## Run Ruby with Bundler
Now that we have dependencies installed, we can run a new instance of Ruby that will have
the locally-installed dependencies loaded.
```
bundle exec irb
```
