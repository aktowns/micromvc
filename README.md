# MicroMVC

A tiny toy opinionated MVC framework. 

## Controllers and Routing

Controllers are placed in `app/controllers/MyController.rb` and subclass `Micro::Controller`.  

```ruby
class HomeController < Micro::Controller
  root '/'

  index do
    render 'Hello, World!'
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micromvc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micromvc

## Usage

TODO: everything.

```ruby
gem install micromvc
micro --init MyAwesomeBlog
cd MyAwesomeBlog
micro --server
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/micromvc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
