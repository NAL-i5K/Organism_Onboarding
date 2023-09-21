#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gff)];
        return LIST;
      }

baseCommand: [modify_refseq_gff_metadata.pl]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_gff)
  - position: 2
    prefix: >
    valueFrom: $(inputs.in_gff).metadata

inputs:
  in_gff:
    type: File

outputs:
  out_gff:
    type: File
    outputBinding: 
      glob: $(inputs.in_gff).metadata