source "http://rubygems.org"

gem "goliath", "~> 1.0.1"
gem "grape", "~> 0.3.2"
gem "grape-entity"
gem "activerecord", "~> 3.2.12"
gem "rake"
gem "uuid", "~> 2.3.7"

platforms :jruby do
  gem "jruby-openssl"
  gem "activerecord-jdbc-adapter", "~> 1.2.7"
  gem "activerecord-jdbcmysql-adapter"
end

group :development do
  gem "github-markup"
end

group :test do
  gem "rspec"
  gem "spork"
  gem "factory_girl"
  gem "database_cleaner"
  gem "json_spec"
  gem "rack-test", "~> 0.6.2", :require => "rack/test"
end

group :development, :test do
  gem "pry"
end
