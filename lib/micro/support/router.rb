module Micro::Support
  class HttpException < Exception
    attr_reader :status, :message
    def initialize(status, message)
      @status, @message = status, message
      super("HTTP Exception: #{status.to_s} the message is: #{message}")
    end
  end

  class Router
    def initialize(routes)
      @routes = routes
    end

    def call(env)
      path = env['PATH_INFO']
      method = env['REQUEST_METHOD'].downcase.to_sym

      route = @routes[path]
      if route.nil?
        static_404 = File.join(Micro::Config.shared.gem_static, '404.erb')
        raise HttpException.new(404, Tilt.new(static_404).render(self, path: path, method: method))
      end
      target = route[method.to_sym]

      controller = target[:controller].new(target)
      controller.initialize_helpers
      controller.instance_eval(&target[:block])
    rescue HttpException => e
      [e.status, {}, [e.message]]
    end
  end
end