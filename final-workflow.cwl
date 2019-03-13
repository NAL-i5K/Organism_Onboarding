#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_wget_genomic: string[]
  in_wget_others: string[]
  in_host: string
  in_login_apollo2: string[] 

steps:
  setup_tree:
    run: tree.cwl
    in:
      in_tree: in_tree 
    out:
      [out_dir]
  download_genomic:
    run: flow_download_genomic/workflow.cwl
    in:
      in_wget_genomic: in_wget_genomic
    out:
      [OUT_genomic_fasta,
       OUT_genomic_gff,
       OUT_txt, #original md5checksum
       OUT_txt2, #extracted form of md5checksum
       OUT_check_log] #log for execution of md5sum -c
  download_others: 
    run: flow_download_others/workflow.cwl
    in:
      in_wget_others: in_wget_others
    out:
      [OUT_others]
  copy2data:
    run: flow_copy2data/workflow.cwl  
    in:
      in_dir: setup_tree/out_dir
      in_tree: in_tree
      #To other_species
      in_fasta: download_genomic/OUT_genomic_fasta
      in_gff: download_genomic/OUT_genomic_gff
      #To working_files
      in_txt: download_genomic/OUT_txt
      in_txt2: download_genomic/OUT_txt2
      in_check_log: download_genomic/OUT_check_log
      in_others: download_others/OUT_others
    out: 
      [OUT_dir]
  apollo2:
    run: flow_apollo2/workflow.cwl
    in:
      in_dir: copy2data/OUT_dir
#      in_dir: setup_tree/out_dir
      in_tree: in_tree
      in_gff: download_genomic/OUT_genomic_gff
      in_fasta: download_genomic/OUT_genomic_fasta
    out: 
      [OUT_dir]
#  copy2apollo-dev:
#    run: flow_copy2apollo-dev/workflow.cwl
#    in:
#      in_dir: apollo2/OUT_dir
#      in_tree: in_tree
#    out:
#      [OUT_dir]
      
outputs:
  final_dir:
    type: Directory
    outputSource: copy2data/OUT_dir
