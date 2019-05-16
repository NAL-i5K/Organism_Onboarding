#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_seq),
                    (inputs.in_tracks_conf),
                    (inputs.in_trackList_json),
                    (inputs.in_tracks),
                    (inputs.in_names),
                    (inputs.in_dir),
        ];
        return LIST;
      }

baseCommand: [cp]
arguments: 
  - position: 1
    prefix: -r
    valueFrom: $(inputs.in_seq)
  - position: 3
    valueFrom: $(inputs.in_tracks_conf)
  - position: 5
    valueFrom: $(inputs.in_trackList_json)
  - position: 7
    valueFrom: $(inputs.in_tracks)
  - position: 9
    valueFrom: $(inputs.in_names)
  - position: 13
    valueFrom: $(inputs.in_dir)
  
inputs: 
  in_seq: 
    type: Directory
  in_tracks_conf: 
    type: File
  in_trackList_json: 
    type: File
  in_tracks: 
    type: Directory
  in_names: 
    type: Directory
  in_dir: 
    type: Directory
      
outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: data/
