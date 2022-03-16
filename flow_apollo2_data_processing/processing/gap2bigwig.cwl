#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - entry: $(inputs.in_fasta)

baseCommand: [gap2bigwig.py]
arguments: 
  - position: 1
    prefix: -o
    valueFrom: $(inputs.in_fasta.basename).gaps.bigwig
  - position : 3
    valueFrom: $(inputs.in_fasta.basename)

inputs:
  in_fasta:
    type: File

outputs: 
  out_gaps_bigwig:
    type: File
    outputBinding: 
      glob: $(inputs.in_fasta.basename).gaps.bigwig