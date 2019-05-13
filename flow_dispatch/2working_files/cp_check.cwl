#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_check)

baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_check.basename)
  - position: 3
    valueFrom: $(inputs.HOME[0])/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/
  
inputs: 
  HOME:
    type: string[]
  in_tree:
    type: string[]
  in_check:
    type: File
      
outputs: []
