#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dir: Directory
  PATH: string[]
  in_tree: string[]
  in_genomic_fasta: File
  deepPATH_genomic_fasta: string[]
  in_genomic_gff: File
  deepPATH_genomic_gff: string[]
  #in_others: File[]
  #in_apollo2: Directory

steps:
  cp_genomic_fasta:
    run: cp_single.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      in_data: in_genomic_fasta
      deepPATH: deepPATH_genomic_fasta
    out: []
  cp_genomic_gff:
    run: cp_single.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      in_data: in_genomic_gff
      deepPATH: deepPATH_genomic_gff
    out: []
  #cp_others:
  #  run: cp_others.cwl
  #  in:
  #    HOME: HOME
  #    in_tree: in_tree
  #    in_others: in_others
  #  out: []
  #cp_apollo2:
  #  run: cp_apollo2.cwl
  #  in:
  #    HOME: HOME
  #    in_tree: in_tree
  #    in_apollo2: in_apollo2
  #  out: []

outputs: []
