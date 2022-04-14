#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dummy: File
  PATH: string[]
  tree: string[]
  in_2bi: File

steps:
  cp_2bi:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      in_data: in_2bi
    out: []

outputs: []
