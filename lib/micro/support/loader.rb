require 'micro/routing'
require 'micro/support/router'
require 'micro/config'

module Micro::Support
  class Loader
    def initialize(path)
      config        = Micro::Config.shared

      root_path     = path
      app_path      = File.join(root_path, 'app')
      lib_path      = File.join(root_path, 'lib')
      config_path   = File.join(root_path, 'config')

      config.root_path    = root_path
      config.app_path     = app_path
      config.lib_path     = lib_path
      config.config_path  = config_path
      config.views_path   = File.join(app_path, 'views')
      config.layouts_path = File.join(config.views_path, 'layouts')

      @controllers  = Dir[File.join(app_path, 'controllers', '**', '*.rb')]
      @models       = Dir[File.join(app_path, 'models', '**', '*.rb')]
      @helpers      = Dir[File.join(app_path, 'helpers', '**', '*.rb')]
      @decorators   = Dir[File.join(app_path, 'decorators', '**', '*.rb')]
      @views        = Dir[File.join(app_path, 'views', '**', '*.html.*')]

      @initializers = File.join(lib_path, 'initializers')
      @tasks        = File.join(lib_path, 'tasks')
    end

    def startup
      [@controllers, @models, @helpers, @decorators].each(&method(:require_all))

      puts "Loaded #{@controllers.length} controller(s)"
      puts "Loaded #{@models.length} model(s)"
      puts "Loaded #{@helpers.length} helper(s)"
      puts "Loaded #{@decorators.length} decorator(s)"

      # Load up controllers based on name
      klasses = @controllers.map do |x|
        file = File.basename(x, '.rb')
        klass = file.capitalize.gsub!(/_(\w)/) { $1.capitalize }
        {klass_name: klass, file: file, klass: Object.const_get(klass)}
      end

      # Flatten our routes from multiple controllers..
      routes = klasses.inject({}){|x,y|x.merge(y[:klass].routes(y))}

      ap routes

      router = Micro::Support::Router.new(routes)

      Rack::Server.start app: router
    end

    private
    def require_all(ary)
      ary.each(&method(:require))
    end
  end
end

