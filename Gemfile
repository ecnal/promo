source "https://rubygems.org"

ruby "3.3.7"

gem "bootsnap", require: false
gem "jsonapi-serializer"
gem "kamal", require: false
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.1"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "shoulda-matchers"
  gem "simplecov"
end
