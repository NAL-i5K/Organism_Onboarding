#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/
  - position: 2
    valueFrom: $(inputs.Apollo_account):$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0]) 
  
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
outputs: 
  out_dummy:
    type: stdout
stdout: dataTransfer-bigwig.dummy
