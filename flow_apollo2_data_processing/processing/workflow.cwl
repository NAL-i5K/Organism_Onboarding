#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  gap_lines: File
  tree: string[]
  scientific_name: string[]
  gff_release_number: string
  url_genomic_gff: string[]
  in_gff: File
  in_fasta: File

steps:
  #step 1
  faToTwoBit:
    run: faToTwoBit.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_2bi] 
  #step 2
  samtools_faidx:
    run: samtools_faidx.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_fai]  
  #step 3
  prepare-refseqs:
    run: prepare-refseqs.cwl               
    in:
      in_fasta: in_fasta
      in_fai: samtools_faidx/out_fai
    out: 
      [out_trackList_json, out_seq, out_tracks_conf,out_data]  
  #step 4
    modify_refseq_gff_metadata:
    run: modify_refseq_gff_metadata.cwl
    in:
      in_gff: in_gff
    out:
      [out_gff]
  #step 4.2
  flatfile-to-json:
    run: flatfile-to-json.cwl
    in:
      tree: tree
      in_gff: out_gff
      scientific_name: scientific_name
      gff_release_number: gff_release_number
      url_genomic_gff: url_genomic_gff 
#      in_trackList_json: prepare-refseqs/out_trackList_json
      in_data: prepare-refseqs/out_data
    out:
      [out_trackList_json, out_tracks]                                
  #step 5
  generate-names:
    run: generate-names.cwl                 
    in:
      in_data: prepare-refseqs/out_data
      in_tracks: flatfile-to-json/out_tracks # making sure that this step is after flatfile-to-json       
    out:
      [out_names]
  #step 6
  gap2bigwig:
    run: gap2bigwig.cwl
    when: $(inputs.gap_lines.size > 0) # skip step 6 if there are no gaps
    in:
      gap_lines: gap_lines
      in_fasta: in_fasta
    out:
      [out_gaps_bigwig]
  #step 7
  GCcontent2bigwig:
    run: GCcontent2bigwig.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_gc_bigwig]
  #step 8
  add-bw-track_gaps:
    run: add-bw-track_gaps.cwl
    when: $(inputs.gap_lines.size > 0) # skip step 8 if there are no gaps
    in:
      gap_lines: gap_lines
      in_gaps_bigwig: gap2bigwig/out_gaps_bigwig
      in_trackList_json: flatfile-to-json/out_trackList_json
    out:
      [out_trackList_json]
  #step 9
  add-bw-track_gc:
    run: add-bw-track_gc.cwl
    in:
      in_gc_bigwig: GCcontent2bigwig/out_gc_bigwig
      in_trackList_json:
        source: [add-bw-track_gaps/out_trackList_json, flatfile-to-json/out_trackList_json]
        pickValue: first_non_null
    out:
      [out_trackList_json]
  #step 10
  add_metadata:
    run: add_metadata.cwl
    in:
      in_fasta: in_fasta
      in_trackList_json: add-bw-track_gc/out_trackList_json
    out:
      [out_trackList_json, out_trackList_json_bak]

outputs: 
  OUT_2bi:
    type: File
    outputSource: faToTwoBit/out_2bi
  OUT_seq:
    type: Directory
    outputSource: prepare-refseqs/out_seq
  OUT_tracks_conf:
    type: File
    outputSource: prepare-refseqs/out_tracks_conf
  OUT_gff:
    type: File
    outputSource: modify_refseq_gff_metadata/out_gff
  OUT_tracks:
    type: Directory
    outputSource: flatfile-to-json/out_tracks
  OUT_names:
    type: Directory
    outputSource: generate-names/out_names
  OUT_gaps_bigwig: # this will be null if there are no gaps
    type: File
    outputSource: gap2bigwig/out_gaps_bigwig
  OUT_gc_bigwig:
    type: File
    outputSource: GCcontent2bigwig/out_gc_bigwig
  OUT_trackList_json:
    type: File
    outputSource: add_metadata/out_trackList_json
  OUT_trackList_json_bak:
    type: File
    outputSource: add_metadata/out_trackList_json_bak     
