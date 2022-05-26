#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  gap_lines: File
  url_string: string
  PATH: string[]
  tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_analyses: string[]
  in_genomic_gff: File
  #
  in_protein_fasta: File
  in_transcript_fasta: File
  in_cds_fasta: File
  in_assembly_readme: File
  in_genePrediction_readme: File
  in_md5checksums: File?
  in_extract: File?
  in_check: File?
  #
  in_2bi: File
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
  processed_gff: File?
  original_gff: File
  url_table_file: string[]

steps:
  setup_folder:
    run: setup_folder.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
    out: [out_dummy]  
  #To other_species
  2other_species: 
    run: 2other_species/workflow.cwl
    in:
      gap_lines: gap_lines
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: in_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      processed_gff: processed_gff
      original_gff: original_gff
      in_protein_fasta: in_protein_fasta
      in_transcript_fasta: in_transcript_fasta
      in_cds_fasta: in_cds_fasta
      in_assembly_readme: in_assembly_readme
      in_genePrediction_readme: in_genePrediction_readme
      #
      deepPATH_apollo2_data: deepPATH_apollo2_data
      in_seq: in_seq
      in_tracks_conf: in_tracks_conf
      in_tracks: in_tracks
      in_names: in_names
      in_trackList_json: in_trackList_json
      in_trackList_json_bak: in_trackList_json_bak
      #
      deepPATH_bigwig: deepPATH_bigwig
      in_gaps_bigwig: in_gaps_bigwig  # this will be null if there are no gaps
      in_gc_bigwig: in_gc_bigwig
      url_table_file: url_table_file
    out: []
  #To working_files
  2working_files:
    run: 2working_files/workflow.cwl
    when: $(inputs.url_string != "NA NA NA NA NA NA\n" ) 
    in:
      url_string: url_string
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      in_md5checksums: in_md5checksums
      in_extract: in_extract
      in_check: in_check
    out: [] 
  #To blat/db/
  2blat:
    run: 2blat/workflow.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      in_2bi: in_2bi
    out: []
  link_bigwig:
    run: link_bigwig.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
    out: []
  link_analyses:
    run: link_analyses.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
    out: []
outputs: 
  out_dummy:
    type: File
    outputSource: setup_folder/out_dummy