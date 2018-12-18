#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_fasta), 
                    (inputs.in_gap2bigwig)];
        return LIST;
      }

baseCommand: [python]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_gap2bigwig.basename)
  - position: 3
    prefix: -o
    valueFrom: $(inputs.in_fasta.basename).gaps.bigwig
  - position : 5
    valueFrom: $(inputs.in_fasta.basename)
    
inputs:
  in_fasta:
    type: File
  in_gap2bigwig:
    type: File

outputs: 
  out_gap2bigwig:
    type: File
    outputBinding: 
      glob: '*.gaps.bigwig'
