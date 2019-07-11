#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in_dir) 

baseCommand: [ln]
arguments: 
  - position: 1
    prefix: -s
    valueFrom: ../../scaffold/bigwig
  - position: 3
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/bigwig
    
inputs:
  in_dir:
    type: Directory
  in_tree:
    type: string[]

outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.in_dir.basename)/
