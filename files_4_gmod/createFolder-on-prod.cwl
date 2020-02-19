#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ssh]
arguments:
  - position: 1
    valueFrom: $(inputs.Gmod_account) 
  - position: 2
    valueFrom: "mkdir -p $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2]) $(inputs.PATH[1])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/remap $(inputs.PATH[2])/$(inputs.tree[0])"

inputs:
  Gmod_account:
    type: string
  PATH:
    type: string[]
  tree:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  deepPATH_analyses:
    type: string[]

outputs: 
  out_dummy:
    type: stdout
stdout: createFolder.dummy  
