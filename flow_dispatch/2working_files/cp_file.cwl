#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_data)
  
baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_data.basename)
  - position: 3
    valueFrom: $(inputs.PATH[1])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/

inputs: 
  PATH:
    type: string[]
  in_tree:
    type: string[]
  in_data:
    type: File

outputs: []
