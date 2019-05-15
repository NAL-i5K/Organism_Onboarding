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
  #step 41
  faToTwoBit:
    run: faToTwoBit.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_2bi] 
  #step 42
  samtools_faidx:
    run: samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_fai]  
  #step 43
  prepare-refseqs:
    run: prepare-refseqs.cwl
    in:
      in_fasta: in_fasta
      in_fai: samtools_faidx/out_wildcard_fai
    out: 
      [out_trackList_json, out_seq, out_tracks_conf] 
  #step 44
  flatfile-to-json:
    run: flatfile-to-json.cwl
    in:
      in_tree: in_tree
      in_gff: in_gff
      in_trackList_json: prepare-refseqs/out_trackList_json
    out:
      [out_trackList_json, out_tracks]
  #step 45
  generate-names:
    run: generate-names.cwl
    in:
      in_tree: in_tree
      in_tracks: flatfile-to-json/out_tracks
    out:
      [out_names]
outputs: 
  OUT_2bi:
    type: File
    outputSource: faToTwoBit/out_wildcard_2bi
     
