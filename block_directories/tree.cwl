#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: to create directory tree
baseCommand: [mkdir, -p]
inputs:
  info:
    type: string[]
    inputBinding:
      position: 2
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
