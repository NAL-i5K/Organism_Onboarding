#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_strings: string[]
#  in_unzip_yml: File

outputs:
  out_workflow:
    type: File[]
    outputSource: step_wget/out_gz

steps:
  step_wget:
    run: wget.cwl
    in:
      in_strings: in_strings
    out: [out_gz]

#  step_unzip:
#    run: unzip.cwl
#    in:
#      in_gz: step_wget/out_gz
#    out: [out_extracted_file]
