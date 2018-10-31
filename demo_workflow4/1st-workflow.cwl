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

  step_gunzip:
    run: block_gunzip/gunzip-workflow.cwl
    in:
      in_gunzip-workflow: step_wget/out_wget
    out: 
      [out_gunzip-workflow]

outputs: 
  out_gunzip-workflow-workflow:
    type: File[]
    outputSource: step_gunzip/out_gunzip-workflow
