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
    valueFrom: $(inputs.PATH[0])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 3
    valueFrom: $(inputs.PATH[0])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/$(inputs.in_tree[2])
  - position: 5
    valueFrom: $(inputs.PATH[0])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/bigwig
  - position: 7
    valueFrom: $(inputs.PATH[1])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/remap
  - position: 9
    valueFrom: $(inputs.PATH[2])/$(inputs.in_tree[0])
      
inputs:
  PATH:
    type: string[]
  in_tree:
    type: string[]

outputs:
  out_dummy:
    type: stdout
stdout: setup_folder.dummy