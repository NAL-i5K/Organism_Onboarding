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
  step_faToTwoBit:
    run: block_faToTwoBit/faToTwoBit.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_wildcard_2bi] 
  #step 42
  step_samtools_faidx:
    run: block_samtools_faidx/samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_wildcard_fai]  
  #step 43
  step_prepare-refseqs:
    run: block_prepare-refseqs/prepare-refseqs.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
      in_fai: step_samtools_faidx/out_wildcard_fai
    out: 
      [out_trackList_json, out_seq] 
  #step 44
  step_flatfile-to-json:
    run: block_flatfile-to-json/flatfile-to-json.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gff: in_gff
      in_trackList_json: step_prepare-refseqs/out_trackList_json
    out:
      [out_trackList_json, out_tracks]
  #step 45
  step_generate-names:
    run: block_generate-names/generate-names.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_tracks: step_flatfile-to-json/out_tracks
    out:
      [out_names]
  #step 46
  step_gap2bigwig:
    run: block_gap2bigwig/gap2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gaps_bigwig]
  #step 47
  step_GCcontent2bigwig:
    run: block_GCcontent2bigwig/GCcontent2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gc_bigwig]
  #step 48
  step_ln:
    run: block_ln/ln.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out:
      []
  #step 49
  step_add-bw-track_gaps:
    run: block_add-bw-track_gaps/add-bw-track_gaps.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gaps_bigwig: step_gap2bigwig/out_wildcard_gaps_bigwig
      in_trackList_json: step_flatfile-to-json/out_trackList_json
    out:
      [out_trackList_json]
  #step 50
  step_add-bw-track_gc:
    run: block_add-bw-track_gc/add-bw-track_gc.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gc_bigwig: step_GCcontent2bigwig/out_wildcard_gc_bigwig
      in_trackList_json: step_add-bw-track_gaps/out_trackList_json
    out:
      [out_trackList_json]
  #step 51
  step_add_metadata:
    run: block_add_metadata/add_metadata.cwl
    in:
      in_tree: in_tree
      in_dir: in_dir
      in_fasta: in_fasta
      in_trackList_json: step_add-bw-track_gc/out_trackList_json
    out:
      []
outputs: []
#  final_trackList_json:
#    type: File
#    outputSource: step_add-bw-track_gc/out_trackList_json
