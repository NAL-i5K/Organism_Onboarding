#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_sample)

baseCommand: [md5sum]
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

inputs: 
  in_sample:
    type: File

outputs: 
  out_sample:
    type: File
    outputBinding:
      glob: '*'
