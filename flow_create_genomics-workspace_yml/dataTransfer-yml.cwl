#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [scp]
arguments:
  - position: 1
    valueFrom: $(inputs.yml_file.location.slice(7))
  - position: 2
    valueFrom: $(inputs.Gmod_account):$(inputs.PATH[1])/$(inputs.tree[0])/$(inputs.tree[1]) 
  
inputs:
  Gmod_account:
    type: string
  tree:
    type: string[]
  PATH: 
    type: string[]
  yml_file:
    type: File
outputs: []
