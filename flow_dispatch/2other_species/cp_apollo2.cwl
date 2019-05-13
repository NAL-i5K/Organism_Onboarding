#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_apollo2)

baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_apollo2.basename)/*
  - position: 3
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/
  
inputs: 
  HOME:
    type: string[]
  in_tree:
    type: string[]
  in_apollo2:
    type: Directory
      
outputs: []
