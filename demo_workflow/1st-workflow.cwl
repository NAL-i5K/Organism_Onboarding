#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_wget: string[]
#  in_unzip_yml: File

steps:
  step_wget:
    run: block_wget/wget.cwl
    in:
      in_wget: in_wget
    out: [out_wget]

#  step_unzip:
#    run: unzip.cwl
#    in:
#      in_gz: step_wget/out_gz
#    out: [out_extracted_file]

outputs:
  out_workflow:
    type: File[]
    outputSource: step_wget/out_wget
