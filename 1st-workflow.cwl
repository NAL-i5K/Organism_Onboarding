#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_wget_yml: File
#  in_unzip_yml: File

outputs:
  gff_gz_out:
    type: File
    outputSource: step_wget/gff_gz_out

steps:
  step_wget:
    run: production/wget.cwl
    in:
      in1-1: in_wget_yml
    out: [gff_gz_out]

#  step_unzip:
#    run: block_unzip/unzip.cwl
#    in:
#      in2-1: in_unzip.yml
#      src: wget/gff_gz
#    out: [gff]
