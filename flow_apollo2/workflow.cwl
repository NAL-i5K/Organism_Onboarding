#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_gff: File
  in_fasta: File

steps:
  processing:
    run: processing/workflow.cwl
    in:
      in_tree: in_tree
      in_gff: in_gff
      in_fasta: in_fasta
    out:
      [
        out_2bi,
        out_seq,
        out_tracks_conf,
        out_trackList_json,
        out_tracks,
        out_names 
      ]
  wrapping:
    run: wrapping/workflow.cwl
    in:      
      in_seq: processing/out_seq
      in_tracks_conf: processing/out_tracks_conf
      in_trackList_json: processing/out_trackList_json
      in_tracks: processing/out_tracks
      in_names: processing/out_names
    out:
      [out_dir]

outputs: 
  OUT_2bi:
    type: File
    outputSource: processing/out_2bi
  OUT_dir:
    type: Directory
    outputSource: wrapping/out_dir
