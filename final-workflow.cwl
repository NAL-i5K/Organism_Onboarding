#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_fasta: File
  in_gff: File

steps:
  apollo2:
    run: flow_apollo2/apollo2-workflow.cwl
    in: 
      in_tree: in_tree
      in_fasta: in_fasta
      in_gff: in_gff
    out:
      [final_dir]

outputs:
  final_dir:
    type: Directory
    outputSource: apollo2/final_dir

