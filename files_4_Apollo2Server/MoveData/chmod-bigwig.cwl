#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ssh]
arguments:
  - position: 1
    valueFrom: $(inputs.Apollo_account)
  - position: 2
    valueFrom: "chmod -R 755 $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])"
  
inputs:
  Apollo_account:
    type: string
  tree:
    type: string[]
  PATH: 
    type: string[]
  deepPATH_bigwig:
    type: string[]  
  in_dummy:
    type: File
outputs: []
