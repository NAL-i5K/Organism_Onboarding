#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: ScatterFeatureRequirement

inputs:
  gap_lines: File
  in_dummy: File
  PATH: string[]
  tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_analyses: string[]
  in_genomic_gff: File
  in_protein_fasta: File[]
  in_transcript_fasta: File
  in_cds_fasta: File
  in_assembly_readme: File
  in_genePrediction_readme: File
  
  #
  deepPATH_apollo2_data: string[]
  in_seq: Directory
  in_tracks_conf: File
  in_tracks: Directory
  in_names: Directory
  in_trackList_json: File
  in_trackList_json_bak: File
  #
  deepPATH_bigwig: string[]
  in_gaps_bigwig: File?  # this will be null if there are no gaps
  in_gc_bigwig: File

steps:
  cp_genomic_fasta:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_genomic_fasta
      in_data: in_genomic_fasta
    out: []
  cp_genomic_gff:
    run: cp_file_4_annotation.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_genomic_gff
    out: []
  cp_protein_fasta:
    run: cp_file_4_annotation.cwl
    scatter: in_data
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_protein_fasta
    out: []
  cp_transcript_fasta:
    run: cp_file_4_annotation.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_transcript_fasta
    out: []
  cp_cds_fasta:
    run: cp_file_4_annotation.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_cds_fasta
    out: []
  cp_assembly_readme:
    run: cp_file.cwl
    in:
      PATH: PATH
      deepPATH: deepPATH_genomic_fasta
      tree: tree
      in_data: in_assembly_readme
    out: []
  cp_genePrediction_readme: 
    run: cp_file_4_annotation.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_genePrediction_readme
    out: []
  # 
  cp_seq:
    run: cp_dir.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_seq
    out: []
  cp_tracks_conf:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_tracks_conf
    out: []
  cp_tracks:
    run: cp_dir.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_tracks
    out: [] 
  cp_names:
    run: cp_dir.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_names
    out: []    
  cp_trackList_json:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_trackList_json
    out: [] 
  cp_trackList_json_bak:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_apollo2_data
      in_data: in_trackList_json_bak
    out: []
  #
  cp_gaps_bigwig:
    run: cp_file.cwl
    when: $(inputs.gap_lines.size > 0)  # skip this step if there are no gaps
    in:
      gap_lines: gap_lines
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_bigwig
      in_data: in_gaps_bigwig
    out: []
  cp_gc_bigwig:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_bigwig
      in_data: in_gc_bigwig
    out: []    
  #
outputs: []
