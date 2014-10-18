module Micro
  class ActionNotFound < Exception; end

  class Controller
    include Micro::Routing
    include Micro::Helpers

    class << self
      def layout(name=nil)
        if name.nil?
          @layout ||= 'default'
        else
          @layout = name
        end
      end
    end

    def initialize(info)
      @info = info
    end

    private

    def layout(content)
      view_name = File.join(Micro::Config.shared.layouts_path, self.class.layout)
      view_file = Micro::View.find_view(view_name)
      if view_file.nil?
        content
      else
        Micro::View.new(view_name, self).render { content }
      end
    end

    def render(str)
      view_folder = @info[:file].gsub(/_controller$/, '')
      view_name = File.join(Micro::Config.shared.views_path, view_folder, @info[:action].to_s)
      rendered = layout(Micro::View.new(view_name, self).render)

      [200, {'Content-Type' => 'text/html'}, [rendered]]
    end
  end
end