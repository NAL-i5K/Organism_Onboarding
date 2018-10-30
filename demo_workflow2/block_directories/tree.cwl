#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: creating directory tree

baseCommand: [mkdir]
inputs:
  info:
    type: string[]
    inputBinding:
      position: 1
      prefix: -p
outputs:
  out_directories:
    type: Directory
    outputBinding:
      glob: '*'

#outputs:
#  example_out:
#    type: Directory
#    outputBinding:
#      glob: $(inputs.info[1])
#      glob:'*'
