#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dir: Directory
  in_tree: string[]
  in_fasta: File
  in_gff: File

steps:
  #step 41
  faToTwoBit:
    run: block_faToTwoBit/faToTwoBit.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_wildcard_2bi] 
  #step 42
  samtools_faidx:
    run: block_samtools_faidx/samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_wildcard_fai]  
  #step 43
  prepare-refseqs:
    run: block_prepare-refseqs/prepare-refseqs.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
      in_fai: samtools_faidx/out_wildcard_fai
    out: 
      [out_trackList_json, out_seq, out_tracks_conf] 
  #step 44
  flatfile-to-json:
    run: block_flatfile-to-json/flatfile-to-json.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gff: in_gff
      in_trackList_json: prepare-refseqs/out_trackList_json
    out:
      [out_trackList_json, out_tracks]
  #step 45
  generate-names:
    run: block_generate-names/generate-names.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_tracks: flatfile-to-json/out_tracks
    out:
      [out_names]
  #step 46
  gap2bigwig:
    run: block_gap2bigwig/gap2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gaps_bigwig]
  #step 47
  GCcontent2bigwig:
    run: block_GCcontent2bigwig/GCcontent2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gc_bigwig]
  #step 48
  ln:
    run: block_ln/ln.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out:
      []
  #step 49
  add-bw-track_gaps:
    run: block_add-bw-track_gaps/add-bw-track_gaps.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gaps_bigwig: gap2bigwig/out_wildcard_gaps_bigwig
      in_trackList_json: flatfile-to-json/out_trackList_json
    out:
      [out_trackList_json]
  #step 50
  add-bw-track_gc:
    run: block_add-bw-track_gc/add-bw-track_gc.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gc_bigwig: GCcontent2bigwig/out_wildcard_gc_bigwig
      in_trackList_json: add-bw-track_gaps/out_trackList_json
    out:
      [out_trackList_json]
  #step 51
  add_metadata:
    run: block_add_metadata/add_metadata.cwl
    in:
      in_tree: in_tree
      in_dir: in_dir
      in_fasta: in_fasta
      in_trackList_json: add-bw-track_gc/out_trackList_json
    out:
      [out_trackList_json, out_trackList_json_bak]
outputs: []
#  final_trackList_json:
#    type: File
#    outputSource: step_add-bw-track_gc/out_trackList_json
