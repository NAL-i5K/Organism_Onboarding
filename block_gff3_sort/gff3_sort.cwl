#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_gff3_sort)

baseCommand: [gff3_sort]
arguments: 
  - position: 1
    prefix: -g
    valueFrom: 
      ${
        var LIST = inputs.in_gff3_sort;
        for (var i = 0; i < LIST.length; i++) {
          if ((LIST[i].nameext == '.gff3')|(LIST[i].nameext == '.gff')) {
            return LIST[i].basename;
          }
        }
      }
  - position: 2
    prefix: -og
    valueFrom: 
      ${
        var LIST = inputs.in_gff3_sort;
        for (var i = 0; i < LIST.length; i++) {
          if ((LIST[i].nameext == '.gff3')|(LIST[i].nameext == '.gff')) {
            return LIST[i].nameroot + '_sorted.gff';
          }
        }
      }

inputs: 
  in_gff3_sort:
    type: File[]

outputs: 
  out_gff3_sort:
    type: File
    outputBinding:
      glob: '*_sorted.gff'
