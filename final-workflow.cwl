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
  url_md5checksums: string[]
  url_genomic_fasta: string[]
  url_genomic_gff: string[]
  url_others: string[]
  in_host: string[]
  in_login_apollo2: string[] 

steps:
  download:
    run: flow_download/workflow.cwl
    in:
      url_md5checksums: url_md5checksums
      url_genomic_fasta: url_genomic_fasta
      url_genomic_gff: url_genomic_gff
      url_others: url_others
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

  #verify:
  #fasta_diff,gff3_QC......
  
  apollo2:
    run: flow_apollo2/workflow.cwl
    in:
      in_tree: in_tree
      in_fasta: md5checksums/OUT_genomic_fasta
      in_gff: md5checksums/OUT_genomic_gff
    out:
      [OUT_dir, OUT_2bi]
  
  dispatch:
    run: flow_dispatch/workflow.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_md5checksums: download/OUT_md5checksums
      in_extract: md5checksums/OUT_extract
      in_check: md5checksums/OUT_check
      in_genomic_fasta: md5checksums/OUT_genomic_fasta
      in_genomic_gff: md5checksums/OUT_genomic_gff
      in_others: md5checksums/OUT_others
      in_apollo2: apollo2/OUT_dir
    out:
      []
  
#  apollo2_createOrganism:
#    run: createOrganism.cwl

  #django_app:
  #BLAST, hmmer.....

outputs: []
#  final_extract:
#    type: File
#    outputSource: md5checksums/OUT_extract
#  final_check:
#    type: File
#    outputSource: md5checksums/OUT_check
#  final_genomic_fasta:
#    type: File
#    outputSource: md5checksums/OUT_genomic_fasta
#  final_genomic_gff:
#    type: File
#    outputSource: md5checksums/OUT_genomic_gff
#  final_others:
#    type: File[]
#    outputSource: md5checksums/OUT_others
