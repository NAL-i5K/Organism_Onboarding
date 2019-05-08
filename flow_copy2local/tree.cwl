#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: creating directory tree
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [mkdir]
arguments:
  - prefix: -p
    position: 1
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/$(inputs.in_tree[2])
  - position: 3
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/bigwig
  - position: 5
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 7
    valueFrom: $(inputs.HOME[0])/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/remap
  - position: 9
    valueFrom: $(inputs.HOME[1])/blat/db/$(inputs.in_tree[0])
      
inputs:
  in_tree:
    type: string[]
  HOME:
    type: string[]
outputs: []

