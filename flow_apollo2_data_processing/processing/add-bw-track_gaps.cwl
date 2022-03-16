#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gaps_bigwig), (inputs.in_trackList_json)];
        return LIST;
      }

baseCommand: [add-bw-track.pl]
arguments: 
  - position: 1
    prefix: --pos_color
    valueFrom: "black"
  - position : 3
    prefix: --neg_color
    valueFrom: "white"
  - position: 5
    prefix: --label
    valueFrom: "Gaps in assembly"
  - position: 7
    prefix: --bw_url 
    valueFrom: bigwig/$(inputs.in_gaps_bigwig.basename)
  - position: 9
    prefix: --in
    valueFrom: $(inputs.in_trackList_json.basename)
  - position: 11
    prefix: --out
    valueFrom: trackList.json
    
inputs:
  in_gaps_bigwig:
    type: File
  in_trackList_json:
    type: File

outputs:
  out_trackList_json:
    type: File
    outputBinding: 
      glob: trackList.json
