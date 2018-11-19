#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:
  in_gitclone-workflow: string[] 

steps:
  step_gitclone:
    run: gitclone.cwl
    scatter: in_gitclone
    in:
      in_gitclone: in_gitclone-workflow
    out: [out_gitclone]

outputs:
  out_gitclone-workflow:
    type: Directory[]
    outputSource: step_gitclone/out_gitclone
