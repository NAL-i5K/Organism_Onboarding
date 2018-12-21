#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir), 
                    (inputs.in_gff), 
                    (inputs.in_JBlibs), 
                    (inputs.in_flatfile)];
        return LIST;
      }

baseCommand: [perl]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_flatfile.basename)
  - position: 3
    prefix: --gff
    valueFrom: $(inputs.in_gff.basename)
  - position: 5
    prefix: --arrowheadClass
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
    
inputs:
  in_flatfile:
    type: File
  in_dir:
    type: Directory 
  in_tree:
    type: string[]
  in_fasta:
    type: File
  in_fai:
    type: File
  in_JBlibs:
    type: File

outputs: []
#  out_faToTwoBit:
#    type: File
#    outputBinding: 
     # glob: '*.2bi'
