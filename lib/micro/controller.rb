module Micro
  class ActionNotFound < Exception; end
  class ViewNotFound < Exception; end

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

    def render(opts={})
      status = opts[:status] ||= 200
      view   = opts[:view] || @info[:action].to_s

      if opts[:text].nil?
        view_folder = @info[:file].gsub(/_controller$/, '')
        view_name = File.join(Micro::Config.shared.views_path, view_folder, view)
        view_file = Micro::View.find_view(view_name)

        raise ViewNotFound.new("View not found for action #{@info[:action]}.") if view_file.nil?

        rendered = layout(Micro::View.new(view_file, self).render)

        content_type = opts[:content_type] ||= 'text/html'

        [status, {'Content-Type' => content_type}, [rendered]]
      else
        content_type = opts[:content_type] ||= 'text/plain'
        [status, {'Content-Type' => content_type}, [opts[:text]]]
      end
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
  end
end