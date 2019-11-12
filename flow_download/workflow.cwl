#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  url_md5checksums: string[]
  url_genomic_fasta: string[]
  url_genomic_gff: string[]
  url_others: string[]

steps:
  wget_md5checksums:
    run: wget_single.cwl
    in:
      in_url: url_md5checksums
    out: [out_wget]
  wget_genomic_fasta:
    run: wget_single.cwl
    in:
      in_url: url_genomic_fasta
    out: [out_wget]
  wget_genomic_gff:
    run: wget_single.cwl
    in:
      in_url: url_genomic_gff
    out: [out_wget]
  wget_others:
    run: wget_multi.cwl
    in:
      in_url: url_others
    out: [out_wget]
   
outputs:  
  OUT_md5checksums:
    type: File
    outputSource: wget_md5checksums/out_wget
  OUT_genomic_fasta:
    type: File
    outputSource: wget_genomic_fasta/out_wget
  OUT_genomic_gff:
    type: File
    outputSource: wget_genomic_gff/out_wget
  OUT_others:
    type: File[]
    outputSource: wget_others/out_wget
