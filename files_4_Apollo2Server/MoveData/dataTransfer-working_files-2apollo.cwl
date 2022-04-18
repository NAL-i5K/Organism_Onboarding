#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: $(inputs.PATH[1])/$(inputs.tree[0])/$(inputs.tree[1])
  - position: 2
    valueFrom: $(inputs.Apollo_account):$(inputs.PATH[1])/$(inputs.tree[0])/

inputs:
  Apollo_account:
    type: string
  PATH:
    type: string[]
  tree:
    type: string[]
  in_dummy:
    type: File
outputs: 
  out_dummy:
    type: stdout
stdout: dataTransfer-working_files-2apollo.dummy
