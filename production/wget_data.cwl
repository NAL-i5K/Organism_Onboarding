#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget, -i]
inputs:
  - id: wget_list
    type: File
    inputBinding:
      position: 1
outputs:
  out:
    type: File[]
    outputBinding:
      glob: '*'
