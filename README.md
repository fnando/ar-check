# AR::Check

[![Travis-CI](https://travis-ci.org/fnando/ar-check.png)](https://travis-ci.org/fnando/ar-check)
[![Code Climate](https://codeclimate.com/github/fnando/ar-check/badges/gpa.svg)](https://codeclimate.com/github/fnando/ar-check)
[![Test Coverage](https://codeclimate.com/github/fnando/ar-check/badges/coverage.svg)](https://codeclimate.com/github/fnando/ar-check/coverage)
[![Gem](https://img.shields.io/gem/v/ar-check.svg)](https://rubygems.org/gems/ar-check)
[![Gem](https://img.shields.io/gem/dt/ar-check.svg)](https://rubygems.org/gems/ar-check)

Enable PostgreSQL's CHECK constraints on ActiveRecord migrations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ar-check"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar-check

## Usage

To create a `CHECK` constraint, just use the method `add_check`.

```ruby
create_table :employees do |t|
  t.integer :salary, null: false
end

add_check :employees, :positive_salary, "salary > 0"
```

This will generate a new constraint using the following SQL statement:

```sql
ALTER TABLE employees
ADD CONSTRAINT positive_salary_on_things
CHECK (salary > 0)
```

To remove it, just using `remove_check`.

```ruby
remove_check :employees, :positive_salary
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fnando/ar-check. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

