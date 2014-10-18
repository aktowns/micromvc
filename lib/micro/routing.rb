require 'awesome_print'

module Micro
  module Routing
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :root

      def root(path)
        @root = path
      end

      def routes(extra={})
        @routes.inject({}) do |x,y|
          route = y[1].to_a.first
          route[1] = route[1].merge(extra)
          y[1] = Hash[*route.flatten]
          x.merge(Hash[*y.flatten])
        end
      end

      # HTTP Verbs
      def get(route, action, &block)
        set_route(route, :get, action, &block)
      end

      def put(route, action, &block)
        set_route(route, :put, action, &block)
      end

      def post(route, action, &block)
        set_route(route, :post, action, &block)
      end

      def patch(route, action, &block)
        set_route(route, :patch, action, &block)
      end

      def delete(route, action, &block)
        set_route(route, :delete, action, &block)
      end

      # CRUD
      def index(&block)
        get('', :index, &block)
      end

      def show(&block)
        get(':id', :show, &block)
      end

      private

      def set_route(route, http, action, &block)
        @routes ||= {}
        @routes[@root + route] ||= {}

        throw 'Redefinition of route' unless @routes[@root + route][action].nil?
        @routes[@root + route][http] = {action: action, controller: self, block: block}
      end
    end
  end
end






