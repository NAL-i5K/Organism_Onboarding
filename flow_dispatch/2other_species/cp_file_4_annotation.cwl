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
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_1[0])/$(inputs.deepPATH_2[0])/$(inputs.tree[2])

inputs: 
  PATH:
    type: string[]
  tree:
    type: string[]
  deepPATH_1:
    type: string[]
  deepPATH_2:
    type: string[]
  in_data:
    type: File

outputs: []
