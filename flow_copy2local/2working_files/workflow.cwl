#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  HOME: string[]
  in_tree: string[]
  in_md5checksums: File
  in_extract: File
  in_check: File

steps:
  cp_md5checksums:
    run: cp_md5checksums.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_md5checksums: in_md5checksums
    out: []
  cp_extract:
    run: cp_extract.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_extract: in_extract
    out: []
  cp_check:
    run: cp_check.cwl
    in:
      HOME: HOME
      in_tree: in_tree
      in_check: in_check
    out: []

outputs: []
