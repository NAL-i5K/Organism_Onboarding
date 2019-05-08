#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_url_md5checksums: string[]
  in_url_genomic_fasta: string[]
  in_url_genomic_gff: string[]
  in_url_others: string[]
  in_host: string[]
  in_login_apollo2: string[] 

steps:
  download:
    run: flow_download/workflow.cwl
    in:
      in_url_md5checksums: in_url_md5checksums
      in_url_genomic_fasta: in_url_genomic_fasta
      in_url_genomic_gff: in_url_genomic_gff
      in_url_others: in_url_others
    out:
      [OUT_md5checksums,   #'*.txt'
       OUT_genomic_fasta,  #'*.gz'
       OUT_genomic_gff,    #'*.gz'
       OUT_others]         #'*.gz'
  md5checksums:
    run: flow_md5checksums/workflow.cwl
    in:
      in_md5checksums: download/OUT_md5checksums
      in_genomic_fasta: download/OUT_genomic_fasta
      in_genomic_gff: download/OUT_genomic_gff
      in_others: download/OUT_others
    out:
      [
       OUT_extract,  #'*.txt2', extracted from *.txt
       OUT_check,    #'*.log', log file for execution of md5sum -c
       OUT_genomic_fasta, #'*.fa, '*.fna', '*.faa'
       OUT_genomic_gff,   #'*.gff', '*.gff3'
       OUT_others 
      ]
  
outputs: 
  final_extract:
    type: File
    outputSource: md5checksums/OUT_extract
  final_check:
    type: File
    outputSource: md5checksums/OUT_check
  final_genomic_fasta:
    type: File
    outputSource: md5checksums/OUT_genomic_fasta
  final_genomic_gff:
    type: File
    outputSource: md5checksums/OUT_genomic_gff
  final_others:
    type: File[]
    outputSource: md5checksums/OUT_others
