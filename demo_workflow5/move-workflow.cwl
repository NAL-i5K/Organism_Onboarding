#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

inputs:
  in_move_file-workflow: File[]
  in_move_dir-workflow: Directory

steps:
  step_move-workflow:
    run: move.cwl
    scatter: in_move_file
    in:
      in_move_file: in_move_file-workflow
      in_move_dir: in_move_dir-workflow
    out: [out_move]

outputs:
  out_move-workflow:
    type: Directory
    outputSource: step_move-workflow/out_move
