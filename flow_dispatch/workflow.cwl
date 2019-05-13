#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  HOME: string[]
  in_tree: string[]
  in_md5checksums: File
  in_extract: File
  in_check: File
  in_genomic_fasta: File
  in_genomic_gff: File
  in_others: File[]
  in_apollo2: Directory

steps:
  setup_folder:
    run: tree.cwl
    in:
      HOME: HOME
      in_tree: in_tree
    out: []
  #To other_species
  2other_species: 
    run: 2other_species/workflow.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_genomic_fasta: in_genomic_fasta
      in_genomic_gff: in_genomic_gff
      in_others: in_others
      in_apollo2: in_apollo2
    out: []
  #To working_files
  2working_files:
    run: 2working_files/workflow.cwl
    in:
      HOME: HOME
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
