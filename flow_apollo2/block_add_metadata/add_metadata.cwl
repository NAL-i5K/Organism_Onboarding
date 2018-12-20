#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir),
                    (inputs.in_from_gaps),
                    (inputs.in_from_gc), 
                    (inputs.in_add_metadata)];
        return LIST;
      }

baseCommand: [perl]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_add_metadata.basename)
  - position: 3
    valueFrom: 
  - position : 5
    valueFrom: $(inputs.in_fasta.basename)
  - position : 7
    valueFrom: $(inputs.in_fasta.basename)
  - position : 9
    valueFrom: $(inputs.in_fasta.basename)
    
inputs:
#  in_fasta:
#    type: File
  in_dir:
    type: Directory
  in_from_gaps:
    type: File
  in_from_gc:
    type: File
  in_add_metadata:
    type: File

outputs: [] 
#  out_GCcontent2bigwig:
#    type: File
#    outputBinding: 
#      glob: '*.gc.bigwig'
