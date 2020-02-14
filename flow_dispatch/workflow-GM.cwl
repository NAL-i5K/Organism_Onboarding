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
  tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_analyses: string[]
  in_protein_fasta: File[]
  in_transcript_fasta: File
  in_cds_fasta: File
  
steps:
  cp_genomic_fasta:
    run: 2other_species/cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH: deepPATH_genomic_fasta
      in_data: in_genomic_fasta
    out: []
  cp_protein_fasta:
    run: 2other_species/cp_file_4_GffProTra.cwl
    scatter: in_data
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_protein_fasta
    out: []
  cp_transcript_fasta:
    run: 2other_species/cp_file_4_GffProTra.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_transcript_fasta
    out: []
  cp_cds_fasta:
    run: 2other_species/cp_file_4_GffProTra.cwl
    in:
      PATH: PATH
      deepPATH_1: deepPATH_genomic_fasta
      deepPATH_2: deepPATH_analyses
      tree: tree
      in_data: in_cds_fasta
    out: []
  
outputs: []
