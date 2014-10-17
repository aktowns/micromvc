module Micro::Support
  class HttpException < Exception
    attr_reader :status, :message
    def initialize(status, message)
      @status, @message = status, message
      super("HTTP Exception: #{status.to_s} the message is: #{message}")
    end
  end

  class Router
    def initialize(routes, oneshot=false)
      @routes, @oneshot = routes, oneshot
      @downward = false
    end

    def call(env)
      exit! if @downward && @oneshot
      @downward = true

      path = env['PATH_INFO']
      method = env['REQUEST_METHOD'].downcase.to_sym

      route = @routes[path]
      raise HttpException.new(404, "no route for '#{path}' exists.") if route.nil?
      target = route[method.to_sym]

      target[:controller].new.instance_eval(&target[:block])
    rescue HttpException => e
      [e.status, {}, [e.message]]
    end
  end


end