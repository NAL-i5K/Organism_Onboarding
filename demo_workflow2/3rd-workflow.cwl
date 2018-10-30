#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_wget: string[]
  in_gitclone: string[]

steps:
  step_wget:
    run: block_wget/wget.cwl
    in:
      in_wget: in_wget
    out: [out_wget]

  step_gitclone:
    run: block_gitclone/gitclone-workflow.cwl
    in:
      in_gitclone: in_gitclone
    out: [out_gitclone]

outputs:
  out_workflow:
    type: File[]
    outputSource: step_wget/out_wget
