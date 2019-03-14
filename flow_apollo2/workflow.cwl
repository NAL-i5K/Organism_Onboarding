#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_dir: Directory
  in_gff: File
  in_fasta: File

steps:
  #step 41
  faToTwoBit:
    run: faToTwoBit.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_dir, out_wildcard_2bi] 
  #step 42
  samtools_faidx:
    run: samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_wildcard_fai]  
  #step 43
  prepare-refseqs:
    run: prepare-refseqs.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
      in_fai: samtools_faidx/out_wildcard_fai
    out: 
      [out_dir, out_trackList_json, out_seq, out_tracks_conf] 
  #step 44
  flatfile-to-json:
    run: flatfile-to-json.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gff: in_gff
      in_trackList_json: prepare-refseqs/out_trackList_json
    out:
      [out_dir, out_trackList_json, out_tracks]
  #step 45
  generate-names:
    run: generate-names.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_tracks: flatfile-to-json/out_tracks
    out:
      [out_dir, out_names]
  #step 46
  gap2bigwig:
    run: gap2bigwig.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_dir, out_wildcard_gaps_bigwig]
  #step 47
  GCcontent2bigwig:
    run: GCcontent2bigwig.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_dir, out_wildcard_gc_bigwig]
  #step 48
  ln:
    run: ln.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_dir]
  #step 49
  add-bw-track_gaps:
    run: add-bw-track_gaps.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gaps_bigwig: gap2bigwig/out_wildcard_gaps_bigwig
      in_trackList_json: flatfile-to-json/out_trackList_json
    out:
      [out_dir, out_trackList_json]
  #step 50
  add-bw-track_gc:
    run: add-bw-track_gc.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gc_bigwig: GCcontent2bigwig/out_wildcard_gc_bigwig
      in_trackList_json: add-bw-track_gaps/out_trackList_json
    out:
      [out_dir, out_trackList_json]
  #step 51
  add_metadata:
    run: add_metadata.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
      in_trackList_json: add-bw-track_gc/out_trackList_json
    out:
      [out_dir, out_trackList_json, out_trackList_json_bak]

outputs: 
  OUT_dir:
    type: Directory
    outputSource: add_metadata/out_dir
  OUT_2bi:
    type: File
    outputSource: faToTwoBit/out_wildcard_2bi
     
