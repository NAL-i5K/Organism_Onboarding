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
  in_gaps_bigwig: File
  in_gc_bigwig: File

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
      in_gaps_bigwig: in_gaps_bigwig
      in_gc_bigwig: in_gc_bigwig
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
  2blat:
    run: 2blat/workflow.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      in_tree: in_tree
      in_2bi: in_2bi
    out: []
  link_bigwig:
    run: link_bigwig.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      in_tree: in_tree
    out: []
outputs: []
