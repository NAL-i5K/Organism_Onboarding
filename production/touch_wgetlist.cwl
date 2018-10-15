#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [echo, -e]
inputs:
  - id: files
    type: string[]
    inputBinding:
      position: 1
      #Default setting of inputBinding :
      #itemSeparator: ","
outputs:
  out:
    type: stdout
stdout: 'wget_list'
