#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_seq: Directory
  in_tracks_conf: File
  in_trackList_json: File
  in_tracks: Directory
  in_names: Directory

steps:
  setup_folder:
    run: tree.cwl
    in: []
    out:
      [out_dir]
  cp:
    run: cp.cwl
    in:
      in_dir: setup_folder/out_dir
      in_seq: in_seq
      in_tracks_conf: in_tracks_conf
      in_trackList_json: in_trackList_json
      in_tracks: in_tracks
      in_names: in_names
    out: 
      [out_dir]

outputs: 
  out_dir:
    type: Directory
    outputSource: cp/out_dir
