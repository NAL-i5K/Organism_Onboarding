#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  in_tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_genomic_gff: string[]
  in_genomic_gff: File
  deepPATH_others: string[]
  #
  in_others: File[]
  in_md5checksums: File
  in_extract: File
  in_check: File
  #
  in_2bi: File
  in_seq: apollo2_data_processing/OUT_seq
  in_tracks_conf: apollo2_data_processing/OUT_tracks_conf
  in_tracks: apollo2_data_processing/OUT_tracks
  in_names: apollo2_data_processing/OUT_names
  in_gaps_bigwig: apollo2_data_processing/OUT_gaps_bigwig
  in_gc_bigwig: apollo2_data_processing/OUT_gc_bigwig
  in_trackList_json: apollo2_data_processing/OUT_trackList_json
  in_trackList_json_bak: apollo2_data_processing/OUT_trackList_json_bak

steps:
  setup_folder:
    run: setup_folder.cwl
    in:
      PATH: PATH
      in_tree: in_tree
    out: [out_dummy]  
  #To other_species
  2other_species: 
    run: 2other_species/workflow.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      in_tree: in_tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: in_genomic_fasta
      deepPATH_genomic_gff: deepPATH_genomic_gff
      in_genomic_gff: in_genomic_gff
      deepPATH_others: deepPATH_others
      in_others: in_others
#      in_apollo2: in_apollo2
    out: []
  #To working_files
  2working_files:
    run: 2working_files/workflow.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      in_tree: in_tree
      in_md5checksums: in_md5checksums
      in_extract: in_extract
      in_check: in_check
    out: [] 
  #To blat/db/
  #2blat:
  
outputs: []
#  OUT_dir:
#    type: Directory
#    outputSource: others/out_dir
