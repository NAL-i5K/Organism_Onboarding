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

  step_rename:
    run: block_rename/rename.cwl
    in:
      in_rename: step_wget/out_wget
    out: [out_rename]

outputs:
  out_workflow:
    type: File[]
    outputSource: step_rename/out_rename
