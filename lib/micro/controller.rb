require 'awesome_print'
require 'pry'

module Micro
  class ActionNotFound < Exception; end

  class Controller
    include Micro::Routing
    include Micro::Helpers

    def initialize(info)
      @info = info
    end

    private

    def layout(content)
      view_name = File.join(Micro::Config.shared.layouts_path, 'default')
      Micro::View.new(view_name, self).render { content }
    end

    def render(str)
      view_folder = @info[:file].gsub(/_controller$/, '')
      view_name = File.join(Micro::Config.shared.views_path, view_folder, @info[:action].to_s)
      [200, {'Content-Type' => 'text/html'}, [layout(Micro::View.new(view_name, self).render)]]
    end
  end
end