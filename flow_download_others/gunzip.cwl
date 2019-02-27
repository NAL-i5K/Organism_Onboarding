#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = inputs.in_gz;
        return LIST;
      }
baseCommand: [gzip]
arguments: 
  - position: 1
    prefix: -df
    valueFrom: $(inputs.in_gz)

inputs:
  in_gz:
    type: File[]

outputs: 
  out_genomic_fasta:
    type: File
    outputBinding:
      glob: '*.fna'
  out_genomic_gff:
    type: File
    outputBinding:
      glob: '*.gff'
#        ${
#          var A = inputs.in_gz;
#          var B = [];
#          for(var i = 0; i < A.length; i++){
#              B = B + A[i].nameroot;
#          }
#          return B;  
#        }
