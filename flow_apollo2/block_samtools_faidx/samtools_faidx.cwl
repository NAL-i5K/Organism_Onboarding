#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_fasta)];
        return LIST;
      }

baseCommand: [samtools]
arguments: 
  - position: 1
    valueFrom: faidx
  - position: 3
    valueFrom: $(inputs.in_fasta.basename)
    
inputs:
  in_fasta:
    type: File

outputs: []
#  out_samtools_faidx:
#    type: File
#    outputBinding: 
#      glob: '*.fai'
