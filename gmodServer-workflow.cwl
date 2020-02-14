#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: InlineJavascriptRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  PATH: string[]
  tree: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  url_md5checksums: string[]
  url_genomic_fasta: string[]
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[] 

steps:
  #step download
  download_md5:
    run: flow_download/wget_single.cwl
    in:
      in_url: url_md5checksums
    out: [out_wget]
  download_genomic_fasta:
    run: flow_download/wget_single.cwl
    in:
      in_url: url_genomic_fasta
    out: [out_wget]
  download_protein_fasta:
    run: flow_download/wget_multi.cwl
    in:
      in_url: url_protein_fasta
    out: [out_wget]
  download_transcript_fasta:
    run: flow_download/wget_single.cwl
    in:
      in_url: url_transcript_fasta
    out: [out_wget]
  download_cds_fasta:
    run: flow_download/wget_single.cwl
    in:
      in_url: url_cds_fasta
    out: [out_wget]
  #step md5checksum and gunzip
  md5checksum_gunzip:
    run: flow_md5checksums/workflow-GM.cwl
    in:
      in_md5checksums: download_md5/out_wget
      in_genomic_fasta: download_genomic_fasta/out_wget
      in_protein_fasta: download_protein_fasta/out_wget
      in_transcript_fasta: download_transcript_fasta/out_wget
      in_cds_fasta: download_cds_fasta/out_wget
    out: 
      [
       OUT_extract, #'*.txt2', extracted from *txt
       OUT_check, #'*.log', log file of execution of md5sum -c
       OUT_genomic_fasta,
       OUT_protein_fasta,
       OUT_transcript_fasta,
       OUT_cds_fasta
      ]
  #step dispatch files
  setup_folder:
    run: flow_dispatch/setup_folder-GM.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
    out: 
      [out_dummy]
  dispatch:
    run: flow_dispatch/workflow-GM.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: md5checksum_gunzip/OUT_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      in_protein_fasta: md5checksum_gunzip/OUT_protein_fasta
      in_transcript_fasta: md5checksum_gunzip/OUT_transcript_fasta
      in_cds_fasta: md5checksum_gunzip/OUT_cds_fasta
    out: [] 
      
outputs: []
