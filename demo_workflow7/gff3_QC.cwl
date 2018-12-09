#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = inputs.in_files;
        LIST.push(inputs.in_gff3_QC_from_update_gff);
        return LIST;
      }
baseCommand: [gff3_QC]
arguments: 
  - position: 1
    prefix: -g
    valueFrom: 
      ${
        var LIST = inputs.in_files;
        for (var i = 0; i < LIST.length; i++) {
          if ((LIST[i].nameext == '.gff3') | (LIST[i].nameext == '.gff')){
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
        return inputs.in_gff3_QC_from_update_gff.nameroot + '_QC.txt'
      }
    
inputs: 
  in_gff3_QC_from_update_gff:
    type: File
  in_files:
    type: File[]
  
outputs: 
  out_gff3_QC:
    type: File
    outputBinding:
      glob: '*_QC.txt'
