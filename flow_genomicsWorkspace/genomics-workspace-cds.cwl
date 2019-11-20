#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dummy: File
  scientific_name: string[]
  managePy_Path: string
  in_fasta_cds: File
  tree: string[]

steps:
  #step 0
  addfile_2_db:
    run: addfile_2_db.cwl
    in:
      in_fasta: in_fasta_cds
    out:
      [out_dummy]
  #step 1
  addblast:
    run: addblast-cds.cwl
    in:
      scientific_name: scientific_name
      managePy_Path: managePy_Path
      in_fasta: in_fasta_cds
      in_dummy: addfile_2_db/out_dummy
      tree: tree
    out:
      [out_dummy] 
  #step 3
  makeblastdb:
    run: makeblastdb.cwl
    in:
      in_fasta: in_fasta_cds
      managePy_Path: managePy_Path
      in_dummy: addblast/out_dummy
    out:
      [out_dummy]
  #step 4
  populatesequence:
    run: populatesequence.cwl
    in:
      in_fasta: in_fasta_cds
      managePy_Path: managePy_Path
      in_dummy: makeblastdb/out_dummy
    out:
      [out_dummy]
  #step 5
  showblast:
    run: showblast.cwl
    in:
      in_fasta: in_fasta_cds
      managePy_Path: managePy_Path
      in_dummy: populatesequence/out_dummy
    out:
      [out_dummy]

outputs: []
