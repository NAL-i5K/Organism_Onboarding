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
    valueFrom: 
      data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/$(inputs.in_tree[2])
  - position: 3
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/bigwig
  - position: 5
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 7
    valueFrom: data/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/remap
  - position: 9
    valueFrom: data/scratch/remap/$(inputs.in_tree[0])
  - position: 11
    valueFrom: data/blat/db/$(inputs.in_tree[0])
      
inputs:
  in_tree:
    type: string[]

outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: '*'

#If in_tree[] change. flow_copy2data need to change
