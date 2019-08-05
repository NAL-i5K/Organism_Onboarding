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
  - prefix: -r
    position: 1
    valueFrom: $(inputs.in_data.basename)
  - position: 3
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH[0])/

inputs: 
  PATH:
    type: string[]
  tree:
    type: string[]
  deepPATH:
    type: string[]
  in_data:
    type: Directory

outputs: []
