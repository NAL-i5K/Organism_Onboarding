#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [rsync]
arguments:
  - prefix: -rlvP
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])
  - position: 2
    valueFrom: $(inputs.Apollo_account):$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/

inputs:
  Apollo_account:
    type: string
  PATH: 
    type: string[]
  tree:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  in_dummy:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: dataTransfer-scaffold-2apollo.dummy
