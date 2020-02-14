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
    valueFrom: "mkdir -p /app/data/other_species/$(inputs.tree[0])/$(inputs.tree[1])"

inputs:
  Apollo_account:
    type: string
  tree:
    type: string[]

outputs: 
  out_dummy:
    type: stdout
stdout: createFolder.dummy  
