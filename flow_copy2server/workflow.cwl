#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dir: Directory
  in_tree: string[]

  #To other_species
  in_fasta: File
  in_gff: File
  
  #To working_files
  in_txt: File
  in_txt2: File
  in_check_log: File 
  in_others: File[]

steps:
  #To other_species
  genomic_fasta:
    run: genomic_fasta.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_fasta: in_fasta
    out: [out_dir]
  genomic_gff:
    run: genomic_gff.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_gff: in_gff
    out: [out_dir]
  #To working_files
  txt:
    run: txt.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_txt: in_txt
    out: [out_dir]
  txt2:
    run: txt2.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_txt2: in_txt2
    out: [out_dir]
  check_log:
    run: check_log.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_check_log: in_check_log
    out: [out_dir]
  others:
    run: others.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
      in_others: in_others
    out: [out_dir]

outputs:
  OUT_dir:
    type: Directory
    outputSource: others/out_dir
