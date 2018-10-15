#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget, -i]
inputs:
  wget_list:
    type: File
    inputBinding:
      position: 1
outputs:
  output_name:
    type: File[]
    outputBinding:
      glob: '*'

