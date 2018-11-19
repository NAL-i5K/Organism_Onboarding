#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  in_wget: string[]

steps:
  step_wget:
    run: wget.cwl
    in:
      in_wget: in_wget
    out: 
      [out_wget]

  step_extract_md5checksums:
    run: extract_md5checksums.cwl
    in: 
      in_extract_md5checksums: step_wget/out_wget
    out:
      [out_extract_md5checksums]

  step_md5sum_check:
    run: md5sum_check.cwl
    in:
      in_md5sum_check_from_wget: step_wget/out_wget
      in_md5sum_check_from_extract: step_extract_md5checksums/out_extract_md5checksums
    out:
      [out_md5sum_check]

 
outputs: 
  out_wget-workflow:
    type: File[]
    outputSource: step_wget/out_wget

  out_extract_md5checksums-workflow:
    type: File
    outputSource: step_extract_md5checksums/out_extract_md5checksums

  out_md5sum_check-workflow:
    type: File
    outputSource: step_md5sum_check/out_md5sum_check
   
