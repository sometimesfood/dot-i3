require 'json'
require 'multi3/virtual_workspace_manager'

module Multi3
  class CLI
    def run(argv)
      valid_commands = %w(switch move)
      usage unless argv.size == 2 && valid_commands.include?(argv[0])

      command = argv[0]
      target = argv[1]

      case command
      when 'switch'
        manager.switch_to_vws(target)
      when 'move'
        raise NotImplementedError, 'Sorry, not yet implemented'
      end
    end

    private

    def manager
      return @manager if @manager
      outputs = JSON[`i3-msg -t get_outputs`]
      workspaces = JSON[`i3-msg -t get_workspaces`]
      @manager = VirtualWorkspaceManager.new(outputs, workspaces)
    end

    def usage
      puts 'usage: multi3 COMMAND TARGET'
    end
  end
end
