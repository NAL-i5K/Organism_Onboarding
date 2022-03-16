#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_fasta) ];
        return LIST;
      }

baseCommand: [GCcontent2bigwig.py]
arguments: 
  - position: 1
    prefix: -o
    valueFrom: $(inputs.in_fasta.basename).gc.bigwig
  - position : 3
    valueFrom: $(inputs.in_fasta.basename)
    
inputs:
  in_fasta:
    type: File

outputs: 
  out_gc_bigwig:
    type: File
    outputBinding: 
      glob: $(inputs.in_fasta.basename).gc.bigwig
