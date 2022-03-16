#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  url_md5checksums: string[]
  url_genomic_fasta: string[]
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[]

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
  wget_protein_fasta:
    run: wget_multi.cwl
    in:
      in_url: url_protein_fasta
    out: [out_wget]
  wget_transcript_fasta:
    run: wget_single.cwl
    in:
      in_url: url_transcript_fasta
    out: [out_wget]
  wget_cds_fasta:
    run: wget_single.cwl
    in:
      in_url: url_cds_fasta
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
  OUT_protein_fasta:
    type: File[]
    outputSource: wget_protein_fasta/out_wget
  OUT_transcript_fasta:
    type: File
    outputSource: wget_transcript_fasta/out_wget
  OUT_cds_fasta:
    type: File
    outputSource: wget_cds_fasta/out_wget
