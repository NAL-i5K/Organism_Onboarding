#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ssh]
arguments:
  - position: 1
    valueFrom: $(inputs.Gmod_account) 
  - position: 2
    valueFrom: "mkdir -p {$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1]),$(inputs.PATH[1])/$(inputs.tree[0])}"

inputs:
  Gmod_account:
    type: string
  PATH:
    type: string[]
  tree:
    type: string[]

outputs: 
  out_dummy:
    type: stdout
stdout: createFolder.dummy  
