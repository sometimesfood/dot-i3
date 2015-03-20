module Multi3
  class VirtualWorkspace
    def initialize(name, physical_workspaces)
      @name = name
      @pws = physical_workspaces
    end

    def switch(focused_output)
      focused_ws = @pws.map { |o, ws| ws if o == focused_output }.compact
      unfocused_ws = @pws.map { |o, ws| ws if o != focused_output }.compact
      (unfocused_ws + focused_ws).map { |ws| "workspace #{ws}"}
    end
  end
end
