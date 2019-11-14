#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  scientific_name: string[]
  in_fasta: File
  managePy_Path: string
  tree: string[]

steps:
  #step 0
  addfile_2_db:
    run: addfile_2_db.cwl
    in:
      in_fasta: in_fasta
    out:
      [out_dummy]
  #step 1
  addorganism:
    run: addorganism.cwl
    in: 
      scientific_name: scientific_name
      in_dummy: addfile_2_db/out_dummy
    out: 
      [out_dummy]
  #step 2
  addblast:
    run: addblast-genome.cwl
    in:
      scientific_name: scientific_name
      in_fasta: in_fasta
      in_dummy: addorganism/out_dummy
      tree: tree
    out:
      [out_dummy] 
  #step 3
  makeblastdb:
    run: makeblastdb.cwl
    in:
      in_fasta: in_fasta
      in_dummy: addblast/out_dummy
    out:
      [out_dummy]
  #step 4
  populatesequence:
    run: populatesequence.cwl
    in:
      in_fasta: in_fasta
      in_dummy: makeblastdb/out_dummy
    out:
      [out_dummy]
  #step 5
  showblast:
    run: showblast.cwl
    in:
      in_fasta: in_fasta
      in_dummy: populatesequence/out_dummy
    out:
      [out_dummy]

outputs:
  out_dummy:
    type: File
    outputSource: addorganism/out_dummy 
 
