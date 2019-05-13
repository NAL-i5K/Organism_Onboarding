#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = inputs.in_others;
        return LIST;
      }
baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_others)
  - position: 3
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/$(inputs.in_tree[2])/
  
inputs: 
  HOME:
    type: string[]
  in_tree:
    type: string[]
  in_others:
    type: File[]
      
outputs: []
