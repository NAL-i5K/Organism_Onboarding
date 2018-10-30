#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
inputs:
  in_wget: string[]

steps:
  step_wget:
    run: block_wget/wget.cwl
    in:
      in_wget: in_wget
    out: [out_wget]

  step_gunzip:
    run: block_gunzip/gunzip.cwl
    in:
      in_gunzip: step_wget/out_wget
    out: [out_gunzip]

outputs: 
  out_workflow:
    type: File[]
    outputSource: step_gunzip/out_gunzip
