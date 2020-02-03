#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gc_bigwig), (inputs.in_trackList_json)];
        return LIST;
      }

baseCommand: [add-bw-track.pl]
arguments: 
  - position: 1
    prefix: --pos_color
    valueFrom: "rgba(0,0,255,50)"
  - position : 3
    prefix: --neg_color
    valueFrom: "rgba(255,255,0,50)"
  - position: 5
    prefix: --bicolor_pivot
    valueFrom: "0.5"
  - position: 7
    prefix: --label
    valueFrom: "GC Content"
  - position: 9
    prefix: --bw_url 
    valueFrom: bigwig/$(inputs.in_gc_bigwig.basename)
  - position: 11
    prefix: --in
    valueFrom: $(inputs.in_trackList_json.basename)
  - position: 13
    prefix: --out
    valueFrom: trackList.json
    
inputs:
  in_gc_bigwig:
    type: File
  in_trackList_json:
    type: File

outputs:
  out_trackList_json:
    type: File
    outputBinding:
      glob: trackList.json
