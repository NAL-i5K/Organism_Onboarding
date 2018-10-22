#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_wget: string[]
#  in_unzip_yml: File

outputs:
  out_workflow:
    type: File
    outputSource: step_unzip/out_extracted_file

steps:
  step_wget:
    run: wget.cwl
    in:
      in_strings: in_wget
    out: [out_gz]

  step_unzip:
    run: unzip.cwl
    in:
      in_gz: step_wget/out_gz
    out: [out_extracted_file]
