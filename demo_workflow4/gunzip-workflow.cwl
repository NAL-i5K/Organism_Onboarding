#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - class: InlineJavascriptRequirement
  - class: ScatterFeatureRequirement

inputs:
  in_gunzip-workflow: File[]

steps:
  step_gunzip-workflow:
    run: gunzip.cwl
    scatter: in_gunzip
    in:
      in_gunzip: in_gunzip-workflow
    out: 
      [out_gunzip]
      
outputs:
  out_gunzip-workflow:
    type: File[]
    outputSource: step_gunzip-workflow/out_gunzip
