#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: /usr/local/blat/db/$(inputs.tree[0])
  - position: 2
    valueFrom: $(inputs.Apollo_account):/usr/local/blat/db/

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
stdout: dataTransfer-blat.dummy
