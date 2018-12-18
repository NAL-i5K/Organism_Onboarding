#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_apollo2_tree), (inputs.in_apollo2_gff3)];
        return LIST;
      }

baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_apollo2_tree.basename)
  - position: 2
    valueFrom: $(inputs.in_apollo2_tree.basename)_ver2
    
inputs: 
  in_apollo2_tree:
    type: Directory
  in_apollo2_gff3:
    type: File
  in_apollo2_fasta:
    type: File

#  in_apollo2_jbrowse:
#    type: Directory
  in_apollo2_wiggle-tools:
    type: Directory

  in_apollo2_data_build_scripts:
    type: Directory

  in_apollo2_setenv:
    type: File
outputs: []
#  out_apollo2:
#    type: Directory
#    outputBinding: 
     # glob: '*'
