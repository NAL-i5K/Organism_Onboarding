#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_faToTwoBit_tree), (inputs.in_faToTwoBit)];
        return LIST;
      }
baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_faToTwoBit.basename)
  - position: 2
    valueFrom: $(inputs.in_faToTwoBit_tree.basename)/blat

inputs: 
  in_faToTwoBit_tree:
    type: Directory
  in_faToTwoBit:
    type: File

outputs: []
#  out_faToTwoBit_tree:
#    type: Directory
#    outputBinding:
#      glob: '*'
