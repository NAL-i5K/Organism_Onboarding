#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  scientific_name: string[]
  tree: string[]
  managePy_Path: string
  in_fasta: File
  in_fasta_protein: File[]
  in_fasta_transcript: File
  in_fasta_cds: File

steps:
  #step 1
  genomics-workspace-genome:
    run: genomics-workspace-genome.cwl
    in:
      in_fasta: in_fasta
      scientific_name: scientific_name
      managePy_Path: managePy_Path
      tree: tree
    out:
      [out_dummy]
  #step 2
  genomics-workspace-protein:
    run: genomics-workspace-protein.cwl
    in: 
      in_fasta_protein: in_fasta_protein
      scientific_name: scientific_name
      tree: tree
      managePy_Path: managePy_Path
      in_dummy: genomics-workspace-genome/out_dummy
    out: 
      []
  #step 3 
  genomics-workspace-transcript:
    run: genomics-workspace-transcript.cwl
    in:
      in_fasta_transcript: in_fasta_transcript
      scientific_name: scientific_name
      tree: tree
      managePy_Path: managePy_Path
      in_dummy: genomics-workspace-genome/out_dummy
    out:
      [] 
  #step 4 
  genomics-workspace-cds:
    run: genomics-workspace-cds.cwl
    in:
      in_fasta_cds: in_fasta_cds
      scientific_name: scientific_name
      tree: tree
      managePy_Path: managePy_Path
      in_dummy: genomics-workspace-genome/out_dummy
    out:
      []

outputs: []
 
