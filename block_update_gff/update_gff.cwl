#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_update_gff)

baseCommand: [update_gff]
arguments: 
  - position: 1
    prefix: -a
    valueFrom: match.tsv 
  - position: 2
    valueFrom:
      ${
        var LIST = inputs.in_update_gff;
        for (var i = 0; i < LIST.length; i++) {
          if ((LIST[i].nameext == '.gff3')|(LIST[i].nameext == '.gff')) {
            return LIST[i].basename;
          }
        }
      }
    
inputs: 
  in_update_gff:
    type: File[]

outputs: 
  out_update_gff:
    type: File[]
    outputBinding:
      glob: '*'
