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
  in_genomic_fasta: File
  in_genomic_gff: File
  in_others: File[]

steps:
  cp_genomic_fasta:
    run: cp_genomic_fasta.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_genomic_fasta: in_genomic_fasta
    out: []
  cp_genomic_gff:
    run: cp_genomic_gff.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_genomic_gff: in_genomic_gff
    out: []
  cp_others:
    run: cp_others.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_others: in_others
    out: []

outputs: []
