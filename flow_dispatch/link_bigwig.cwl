#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    position: 1
    valueFrom: ../../scaffold/bigwig
  - prefix: -t
    position: 3
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/jbrowse/data

inputs:
  in_dummy: 
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]

outputs: []