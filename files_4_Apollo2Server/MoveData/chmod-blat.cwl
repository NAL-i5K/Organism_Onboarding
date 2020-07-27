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
    valueFrom: "sudo chmod -R 755 $(inputs.PATH[2])/$(inputs.tree[0])"

inputs:
  Apollo_account:
    type: string
  PATH:
    type: string[]
  tree:
    type: string[]
  in_dummy:
    type: File
outputs: []
