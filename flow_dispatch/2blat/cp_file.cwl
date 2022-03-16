#!/usr/bin/env cwl-runner

cwlVersion: v1.2
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
    valueFrom: $(inputs.PATH[2])/$(inputs.tree[0])/

inputs: 
  PATH:
    type: string[]
  tree:
    type: string[]  
  in_data:
    type: File

outputs: []
