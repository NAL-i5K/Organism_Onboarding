#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:
  in_strings_gitclone: string[] 

steps:
  step_gitclone:
    run: gitclone.cwl
    scatter: in_gitclone
    in:
      in_gitclone: in_strings_gitclone
    out: [out_gitclone]

outputs:
  out_workflow:
    type: Directory[]
    outputSource: step_gitclone/out_gitclone
