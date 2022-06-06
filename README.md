# Checkout Coding Challenge



Our client is an online marketplace, here is a sample of some of the products available on our site:


| Product code  | Name                   | Price      |
|---------------|------------------------|------------|
| 001           | Lavender heart         | £9.25      |
| 002           | Personalised cufflinks | £45.00     |
| 003           | Kids T-shirt           | £19.95     |


Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

If you spend over £60, then you get 10% of your purchase
If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

```ruby
  co = Checkout.new(promotional_rules)
  co.scan(item)
  co.scan(item)
  price = co.total
```

Using plain Ruby, implement a checkout system that fulfills these requirements.


### Test data

```
Basket: 001,002,003
Total price expected: £66.78

Basket: 001,003,001
Total price expected: £36.95

Basket: 001,002,001,003
Total price expected: £73.76
```

## Usage


```
$ irb -r ./lib/checkout.rb
```

### Test data 1

```ruby
rules = [
  Rules::BulkDiscount.new(item: ItemStorage.find(001), minimum_quantity: 2, price_reduction: 0.75), 
  Rules::Discount.new(percentage: 0.10, minimum_spent: 60)
]

checkout = Checkout.new(rules)

checkout.scan(001)
checkout.scan(002)
checkout.scan(003)

checkout.total

=> 66.78
```

### Test data 2

```ruby
rules = [
  Rules::BulkDiscount.new(item: ItemStorage.find(001), minimum_quantity: 2, price_reduction: 0.75), 
  Rules::Discount.new(percentage: 0.10, minimum_spent: 60)
]

checkout = Checkout.new(rules)

checkout.scan(001)
checkout.scan(003)
checkout.scan(001)

checkout.total

=> 36.95
```

### Test data 3

```ruby
rules = [
  Rules::BulkDiscount.new(item: ItemStorage.find(001), minimum_quantity: 2, price_reduction: 0.75), 
  Rules::Discount.new(percentage: 0.10, minimum_spent: 60)
]

checkout = Checkout.new(rules)

checkout.scan(001)
checkout.scan(002)
checkout.scan(001)
checkout.scan(003)

checkout.total

=> 73.76
```


## What is provided

- [RuboCop](https://docs.rubocop.org/rubocop/index.html)
- [RSpec](https://relishapp.com/rspec)
- [Pry](https://github.com/pry/pry)
- [Simplecov](https://github.com/simplecov-ruby/simplecov)
- [Github Workflows](https://docs.github.com/en/actions/using-workflows)

## Commands

### Installation

This project was created using ruby 2.7.2 (see .ruby-version).

I use rbenv to install different ruby versions, you may need to install [homebrew](https://brew.sh).

```bash

$ brew install ruby-build rbenv

$ rbenv install

$ gem install bundler

$ bundle install
```

### Testing with rspec

```
$ rspec
```

### Linting with RuboCop

```
$ bundle exec rubocop
```

If you want to correct all cops

```
$ bundle exec rubocop -A
```

### Test coverage

After running the rspec command, a new directory is created to show test coverage

```
$ open coverage/index.html
```
