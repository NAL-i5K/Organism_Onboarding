#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/
  - position: 2
    valueFrom: $(inputs.Gmod_account):$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1]) 
  
inputs:
  Gmod_account:
    type: string
  tree:
    type: string[]
  PATH: 
    type: string[]  
  in_dummy:
    type: File
outputs: 
  out_dummy:
    type: stdout
stdout: dataTransfer-fasta.dummy
