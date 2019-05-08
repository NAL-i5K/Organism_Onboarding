#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_wget_others: string[]
  
steps:
  wget:
    run: wget.cwl
    in:
      in_wget_others: in_wget_others
    out:
      [out_txt,
       out_gz
      ]
  extract_md5checksums:
    run: extract_md5checksums.cwl
    in:
      in_txt: wget/out_txt
      in_gz: wget/out_gz
    out:
     [out_txt2]
  check_md5sum:
    run: check_md5sum.cwl
    in:
      in_txt2: extract_md5checksums/out_txt2
      in_gz: wget/out_gz
    out:
      [out_check_log]
  gunzip:
    run: gunzip.cwl
    in:
      in_gz: wget/out_gz
    out:
      [out_others]
  #fasta_validator    
  #gff_validator
    
outputs:
#  OUT_txt2:
#    type: File
#    outputSource: extract_md5checksums/out_txt2
#  OUT_check_log:
#    type: File
#    outputSource: check_md5sum/out_check_log
  OUT_others:
    type: File[]
    outputSource: gunzip/out_others
