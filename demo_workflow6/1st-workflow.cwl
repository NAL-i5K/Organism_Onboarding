#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  in_strings_gitclone: string[] 
  in_wget: string[]
  in_tree: string[]

steps:
  step_gitclone:
    run: block_gitclone/gitclone-workflow.cwl
    in:
      in_strings_gitclone: in_strings_gitclone
    out:
      [out_gitclone-workflow] 

  step_wget:
    run: block_wget/wget.cwl
    in:
      in_wget: in_wget
    out: 
      [out_wget]

  step_tree:
    run: block_tree/tree.cwl
    in:
      in_tree: in_tree
    out:
      [out_tree]

outputs: 
  out_gitclone-workflow:
    type: Directory[]
    outputSource: step_gitclone/out_gitclone-workflow

  out_wget:
    type: File[]
    outputSource: step_wget/out_wget

  out_tree:
    type: Directory
    outputSource: step_tree/out_tree
