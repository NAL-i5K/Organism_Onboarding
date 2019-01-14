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
  step_faToTwoBit:
    run: block_faToTwoBit/faToTwoBit.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out:
      [out_wildcard_2bi] 
  step_samtools_faidx:
    run: block_samtools_faidx/samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_wildcard_fai]  
  step_prepare-refseqs:
    run: block_prepare-refseqs/prepare-refseqs.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
      in_fai: step_samtools_faidx/out_wildcard_fai
    out: 
      [out_trackList_json] 
#  step_flatfile-to-json:
#    run: block_flatfile-to-json/flatfile-to-json.cwl
#    in:
#      in_dir: in_dir
#      in_tree: in_tree
#      in_gff: in_gff
#    out:
#      []
  #step_generate-names:
  #
  step_gap2bigwig:
    run: block_gap2bigwig/gap2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gaps_bigwig]
  step_GCcontent2bigwig:
    run: block_GCcontent2bigwig/GCcontent2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_dir: in_dir
      in_tree: in_tree
    out:
      [out_wildcard_gc_bigwig]
  step_ln:
    run: block_ln/ln.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out:
      []
  step_add-bw-track_gaps:
    run: block_add-bw-track_gaps/add-bw-track_gaps.cwl
    in:
      in_trackList_json: step_prepare-refseqs/out_trackList_json
      in_gaps_bigwig: step_gap2bigwig/out_wildcard_gaps_bigwig
    out:
      [out_trackList_json]
  step_add-bw-track_gc:
    run: block_add-bw-track_gc/add-bw-track_gc.cwl
    in:
      in_trackList_json: step_add-bw-track_gaps/out_trackList_json
      in_gc_bigwig: step_GCcontent2bigwig/out_wildcard_gc_bigwig
    out:
      [out_trackList_json]
  #step_add_metadata:

outputs: []
#  final_trackList_json:
#    type: File
#    outputSource: step_add-bw-track_gc/out_trackList_json
