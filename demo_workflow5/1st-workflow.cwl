#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  in_wget: string[]

steps:
  step_wget:
    run: block_wget/wget.cwl
    in:
      in_wget: in_wget
    out: 
      [out_wget]
  step_md5sum_check:
    run: md5sum_check.cwl
    in:
      in_md5sum_check: step_wget/out_wget
    out:
      [out_md5sum_check]
#  step_gunzip:
#    run: block_gunzip/gunzip-workflow.cwl
#    in:
#      in_gunzip-workflow: step_wget/out_wget
#    out: [out_gunzip-workflow]

outputs: 
  #out_wget-workflow:
  #  type: File[]
  #  outputSource: step_wget/out_wget
  out_md5sum_check-workflow:
    type: File
    outputSource: step_md5sum_check/out_md5sum_check

