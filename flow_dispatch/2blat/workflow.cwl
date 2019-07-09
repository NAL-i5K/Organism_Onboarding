#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  in_2bi: File

steps:
  cp_2bi:
    run: cp_file.cwl
    in:
      PATH: PATH
      in_data: in_2bi
    out: []

outputs: []
