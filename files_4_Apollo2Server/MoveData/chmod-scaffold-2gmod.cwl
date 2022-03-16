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
    valueFrom: "sudo chmod -R 755 $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])"

inputs:
  Gmod_account:
    type: string
  PATH: 
    type: string[]
  tree:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  in_dummy:
    type: File
outputs: []
