#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget]

inputs:
  in_wget:
    type: string[]
    inputBinding:
      position: 1

outputs: 
  out_wget_txt:
    type: File[]
    outputBinding:
      glob: ['*.txt']
  out_wget_fasta:
    type: File[]
    outputBinding:
      glob: ['*.fa.gz', '*.faa.gz', '*.fna.gz']
  out_wget_gff:
    type: File[]
    outputBinding:
      glob: ['*.gff.gz', '*.gff3.gz']
    

