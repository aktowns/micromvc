module Micro
  class ActionNotFound < Exception; end

  class Controller
    include Micro::Routing

    def initialize(info)
      @info = info
    end

    private

    def render(str)
      view_folder = @info[:file].gsub(/_controller$/, '')
      view_name = File.join(Micro::Config.shared.views_path, view_folder, @info[:action].to_s)
      [200, {'Content-Type' => 'text/html'}, [Micro::View.new(view_name).render]]
    end
  end
end