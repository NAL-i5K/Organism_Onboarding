#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in_gz)

baseCommand: [gzip]
arguments: 
  - position: 1
    prefix: -df
    valueFrom: $(inputs.in_gz.basename)

inputs:
  in_dummy:
    type: File
  in_gz:
    type: File

outputs: 
  out_gz:
    type: File
    outputBinding:
      glob: $(inputs.in_gz.nameroot) 
#${
#          var A = inputs.in_gz;
#          var B = [];
#          for(var i = 0; i < A.length; i++){
#              B = B + A[i].nameroot;
#          }
#          return B;  
#        }
