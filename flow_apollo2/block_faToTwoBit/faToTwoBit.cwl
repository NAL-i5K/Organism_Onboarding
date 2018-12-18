#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir), 
                    (inputs.in_fasta), 
                    (inputs.in_faToTwoBit)];
        return LIST;
      }

baseCommand: [faToTwoBit]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_fasta.basename)
  - position: 3
    valueFrom: $(inputs.in_dir.basename)/blat/db/$(inputs.in_tree[0])/$(inputs.in_fasta.basename).2bi
    
inputs:
  in_dir:
    type: Directory 
  in_tree:
    type: string[]
  in_fasta:
    type: File
  in_faToTwoBit:
    type: File

outputs: []
#  out_faToTwoBit:
#    type: File
#    outputBinding: 
     # glob: '*.2bi'
