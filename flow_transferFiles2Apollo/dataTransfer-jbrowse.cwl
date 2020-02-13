#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: /app/data/other_species/$(inputs.tree[0])/$(inputs.tree[1])/jbrowse
  - position: 2
    valueFrom: $(inputs.Apollo_account):/app/data/other_species/$(inputs.tree[0])/$(inputs.tree[1])/

inputs:
  Apollo_account:
    type: string
  tree:
    type: string[]
  in_dummy:
    type: File
outputs: 
  out_dummy:
    type: stdout
stdout: dataTransfer-jbrowse.dummy
