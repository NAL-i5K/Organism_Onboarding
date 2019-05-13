#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_genomic_fasta)

baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_genomic_fasta.basename)
  - position: 3
    valueFrom: $(inputs.HOME[0])/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/
  
inputs: 
  HOME:
    type: string[]
  in_tree:
    type: string[]
  in_genomic_fasta:
    type: File
      
outputs: []
