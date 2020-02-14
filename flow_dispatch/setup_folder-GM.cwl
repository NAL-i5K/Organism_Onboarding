#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: creating directory tree
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [mkdir]
arguments:
  - position: 1
    prefix: -p
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])
  - position: 2
    valueFrom: $(inputs.PATH[1])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/remap
  - position: 3
    valueFrom: $(inputs.PATH[2])/$(inputs.tree[0])
      
inputs:
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
stdout: setup_folder.dummy
