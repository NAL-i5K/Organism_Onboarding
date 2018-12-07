#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_files)

baseCommand: [gff3_QC]
arguments: 
  - position: 1
    prefix: -g
    valueFrom: 
      ${
        var LIST = inputs.in_run_gff3_QC;
        for (var i = 0; i < LIST.length; i++) {
          if (LIST[i].nameext == '.gff3') {
            return LIST[i].basename;
          }
        }
      }

  - position: 2
    prefix: -f
    valueFrom: 'new.fa'

  - position: 3
    prefix: -o
    valueFrom:
      ${
        var LIST = inputs.in_run_gff3_QC;
        for (var i = 0; i < LIST.length; i++) {
          if (LIST[i].nameext == '.gff3') {
            return LIST[i].nameroot + '_QC.txt';
          }
        }
      }
    
inputs: 
  in_files:
    type: File[]

outputs: 
  out_run_gff3_QC:
    type: File
    outputBinding:
      glob: '*_QC.txt'

