#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dummy: File
  PATH: string[]
  tree: string[]
  in_md5checksums: File
  in_extract: File
  in_check: File
  
steps:
  cp_md5checksums:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      in_data: in_md5checksums
    out: []
  cp_extract:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      in_data: in_extract
    out: []
  cp_check:
    run: cp_file.cwl
    in:
      PATH: PATH
      tree: tree
      in_data: in_check
    out: []

outputs: []
