#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [manage.py]
arguments: 
  - position: 1
    valueFrom: addblast
  - position: 3
    valueFrom: $(inputs.tree[3])
  - position: 5
    valueFrom: $(inputs.tree[4])
  - position: 7
    prefix: -species
    valueFrom: $(inputs.tree[4])
  - position: 9
    prefix: -t
    valueFrom: $(inputs.in_genomic_fasta_seq_type) 
  - position: 11
    prefix: -f
    valueFrom: $(inputs.in_fasta.basename)
inputs:
  in_genomic_fasta_seq_type:
    type: string
  tree:
    type: string[]
  in_fasta:
    type: File
  
outputs: []
