#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_fasta_diff)

baseCommand: [fasta_diff]
arguments: 
  - position: 1
    valueFrom: 'Bombus_terrestris.1.0.fa'

  - position: 2
    valueFrom: 'GCF_000214255.1_Bter_1.0_genomic.fna' 

  - position: 3
    prefix: -o
    valueFrom: 'match.tsv'
  
  - position: 4
    prefix: -r
    valueFrom: 'report.txt'

inputs: 
  in_fasta_diff:
    type: File[]

outputs: 
  out_fasta_diff_report:
    type: File
    outputBinding:
      glob: '*.txt'
  out_fasta_diff_match:
    type: File
    outputBinding:
      glob: '*.tsv'
