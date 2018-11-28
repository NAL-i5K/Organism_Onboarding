#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_mv)
        writable: true #Default: Read-only Dir

baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom:
      ${
        LIST = inputs.in_mv.listing;
        for (var i = 0; i < LIST.length; i++) {
          if (LIST[i].nameext == '.gff') {
             return LIST[i].basename;
          }
        }
      }
  - position: 2
    valueFrom: $(inputs.in_mv.basename)/data/

inputs: 
  in_mv:
    type: Directory
      
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: '*'
