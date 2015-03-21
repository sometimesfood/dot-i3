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

    def move(focused_output)
      pws = @pws[focused_output]
      "move container to workspace #{pws}"
    end
  end
end
