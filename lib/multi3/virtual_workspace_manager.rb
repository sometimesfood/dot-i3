require 'multi3/virtual_workspace'

module Multi3
  class VirtualWorkspaceManager
    def initialize(outputs, workspaces)
      @outputs = active_outputs(outputs)
      @focused_workspace = focused_workspace(workspaces)

      vws_names = ('1'..'10').to_a
      pws_suffixes = ('a'..'z').take(@outputs.size)
      @vws = virtual_workspaces(vws_names, pws_suffixes)
    end

    def switch_to_vws(name)
      focused_output = @focused_workspace['output']
      command = @vws[name].switch(focused_output).join(',')
      `i3-msg #{command}`
    end

    private

    def active_outputs(outputs)
      outputs.select { |o| o['active'] }.map { |o| o['name'] }
    end

    def focused_workspace(workspaces)
      workspaces.find { |w| w['focused'] }
    end

    def virtual_workspaces(vws_names, pws_suffixes)
      Hash[vws_names.map do |name|
             pws_names = pws_suffixes.map { |suffix| name + suffix }
             pws = Hash[@outputs.zip(pws_names)]
             vws = VirtualWorkspace.new(name, pws)
             [ name,  vws ]
           end]
    end
  end
end
