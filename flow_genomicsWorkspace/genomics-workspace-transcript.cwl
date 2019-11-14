#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: ScatterFeatureRequirement

inputs:
  in_dummy: File[]
  scientific_name: string[]
  in_fasta_transcript: File[]
  tree: string[]

steps:
  #step 0
  addfile_2_db:
    run: addfile_2_db.cwl
    scatter: in_fasta
    in:
      in_fasta: in_fasta_transcript
    out:
      [out_dummy]
  #step 1
  addblast:
    run: addblast-transcript.cwl
    scatter: [in_fasta, in_dummy]
    scatterMethod: dotproduct
    in:
      scientific_name: scientific_name
      in_fasta: in_fasta_transcript
      in_dummy: addfile_2_db/out_dummy
      tree: tree
    out:
      [out_dummy] 
  #step 3
  makeblastdb:
    run: makeblastdb.cwl
    scatter: [in_fasta, in_dummy]
    scatterMethod: dotproduct
    in:
      in_fasta: in_fasta_transcript
      in_dummy: addblast/out_dummy
    out:
      [out_dummy]
  #step 4
  populatesequence:
    run: populatesequence.cwl
    scatter: [in_fasta, in_dummy]
    scatterMethod: dotproduct
    in:
      in_fasta: in_fasta_transcript
      in_dummy: makeblastdb/out_dummy
    out:
      [out_dummy]
  #step 5
  showblast:
    run: showblast.cwl
    scatter: [in_fasta, in_dummy]
    scatterMethod: dotproduct
    in:
      in_fasta: in_fasta_transcript
      in_dummy: populatesequence/out_dummy
    out:
      [out_dummy]

outputs: []
