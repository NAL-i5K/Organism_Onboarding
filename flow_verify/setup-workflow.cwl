#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_fasta: File
  in_gff: File

steps:
  #step 51
  add_metadata:
    run: block_add_metadata/add_metadata.cwl
    in:
      in_dir: tree/out_tree
      in_tree: in_tree
      in_fasta: in_fasta
      in_trackList_json: add-bw-track_gc/out_trackList_json
    out:
      [out_trackList_json, out_trackList_json_bak]
outputs:
  final_dir:
    type: Directory
    outputSource: tree/out_tree
