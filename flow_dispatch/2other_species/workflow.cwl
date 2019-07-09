#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: ScatterFeatureRequirement

inputs:
  in_dummy: File
  PATH: string[]
  in_tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_genomic_gff: string[]
  in_genomic_gff: File
  deepPATH_others: string[]
  in_others: File[]
  #in_apollo2: Directory

steps:
  cp_genomic_fasta:
    run: cp_file.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      deepPATH: deepPATH_genomic_fasta
      in_data: in_genomic_fasta
    out: []
  cp_genomic_gff:
    run: cp_file.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      deepPATH: deepPATH_genomic_gff
      in_data: in_genomic_gff
    out: []
  cp_others:
    run: cp_file.cwl
    scatter: in_data
    in:
      PATH: PATH
      in_tree: in_tree
      deepPATH: deepPATH_others
      in_data: in_others
    out: []

  #cp_apollo2:
  #  run: cp_dir.cwl
  #  in:
  #    HOME: HOME
  #  out: []

outputs: []
