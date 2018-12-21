#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_from_gaps), 
                    (inputs.in_JBlibs),
                    (inputs.in_add_track)];
        return LIST;
      }

baseCommand: [perl]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_add_track.basename)
  - position: 3
    prefix: --pos_color
    valueFrom: "black"
  - position : 5
    prefix: --neg_color
    valueFrom: "white"
  - position: 7
    prefix: --label
    valueFrom: "Gaps in assembly"
  - position: 9
    prefix: --bw_url 
    valueFrom: $(inputs.in_from_gaps.basename)
    
inputs:
#  in_fasta:
#    type: File
#  in_dir:
#    type: Directory
#  in_tree:
#    type: string[]
  in_from_gaps:
    type: File
  in_add_track:
    type: File
  in_JBlibs:
    type: File

outputs: [] 
#  out_GCcontent2bigwig:
#    type: File
#    outputBinding: 
#      glob: '*.gc.bigwig'
