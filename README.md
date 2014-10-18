# MicroMVC

A tiny toy opinionated MVC framework. 

## Controllers, Routing and Helpers

Controllers are placed in `app/controllers/MyController.rb` and subclass `Micro::Controller`.  
Routes are defined inline on a controller, multiple controllers can fulfil a single root 
but cannote contain duplicate routes. 

Helpers can be loaded and are available from both controllers and views by using  `helper MyHelperModule`
or `helpers [MyHelperA, MyHelperB]`. 

```ruby
class MyController < Micro::Controller
  root '/'                    # this is the root path for this controller.

  helper MagicHelper          # Explicitly choose which helpers to import

  index do                    # CRUD actions are aliased for easy use.
    render 'Hello, World!'    # At the moment only text rendering.
  end
  
  get '/custom', :custom do   # Custom actions can be defined by http verbs.
    render 'A custom action!'
  end
end                           # FIN.
```

## Models and Decorators

Models are placed in `app/models/MyModel.rb` and subclass `Micro::Model`. 
There are no hard restrictions on what a model can be at the moment, but they are loaded 
in the context of all controllers. 

Models are able to import `Decorators` similar to how controllers import `Helpers`

```ruby 
class MyModel < Micro::Model 
  decorator FullNameDecorator
  
  def first_name
    "Ashley"
  end 
  
  def last_name
    "Towns"
  end
end

# model = MyModel.new
# model.first_name 
# model.full_name # from a decorator

```

## Views, Layouts, Templating 

Views can be in any language supported by [Tilt](Tilt) by default only `.erb` support is supplied.
Views share the scope with the controller similar to how Rails works so for example in your controller if you have

```ruby 
# app/controller/demo_controller.rb
def index do 
  @posts = Post.all
end
``` 

Then in your `app/views/demo/index.erb` you can do

```erb 
<% @posts.each do |post| %>
...
<% end %>
```

Helpers imported on the controller are available to views. 

A default layout can be placed in `app/views/layouts/default.extension` and can be 
overriden on a per-controller basis by using `layout <layout name>` inside a controller.

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
