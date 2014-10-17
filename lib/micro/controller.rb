module Micro
  class ActionNotFound < Exception; end

  class Controller
    include Micro::Routing

    private

    def render(str)
      [200, {}, [str]]
    end
  end
end