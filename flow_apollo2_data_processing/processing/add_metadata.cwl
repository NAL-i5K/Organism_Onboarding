#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_fasta), (inputs.in_trackList_json)];
        return LIST;
      }

baseCommand: [add_metadata_to_GC_gap_bigwig_tracks.pl]
arguments: 
  - position: 1
    valueFrom: trackList.json
  - position: 3
    valueFrom: trackList.json.bak-metadata
  - position : 5
    valueFrom: $(inputs.in_fasta.basename).gc.bigwig
  - position : 7
    valueFrom: $(inputs.in_fasta.basename).gaps.bigwig
    
inputs:
  in_fasta:
    type: File
  in_trackList_json:
    type: File

outputs:
  out_trackList_json:
    type: File
    outputBinding: 
      glob: trackList.json
  out_trackList_json_bak:
    type: File
    outputBinding: 
      glob: trackList.json.bak-metadata
