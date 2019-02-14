#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_wget: string[]

steps:
  tree:
    run: tree.cwl
    in:
      in_tree: in_tree
    out:
      [out_tree]
  wget:
    run: wget.cwl
    in:
      in_wget: in_wget
    out:
      [out_md5checksums_txt,
       out_gz
      ]
  extract_md5checksums:
    run: extract_md5checksums.cwl
    in:
      in_md5checksums_txt: wget/out_md5checksums_txt
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
      [out_gunzip]
    
outputs:
  OUT_dir:
    type: Directory
    outputSource: tree/out_tree
#  final_txt2:
#    type: File
#    outputSource: extract_md5checksums/out_txt2
#  final_check_log:
#    type: File
#    outputSource: check_md5sum/out_check_log
  OUT_gunzip:
    type: File[]
    outputSource: gunzip/out_gunzip
