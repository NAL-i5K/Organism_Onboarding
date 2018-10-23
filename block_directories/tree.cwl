

cwlVersion: v1.0
class: CommandLineTool
label: creating directory tree

baseCommand: [mkdir, -p]
inputs:
  info:
    type: string[]
    inputBinding:
      position: 1
outputs:
  example_out:
    type: Directory[]
    outputBinding:
      glob: "*"

#outputs:
#  example_out:
#    type: Directory
#    outputBinding:
#      glob: $(inputs.info[1])
#      glob:'*'
