#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_wget: string[]

steps:
  setup:
    run: flow_setup/setup-workflow.cwl
    in:
      in_tree: in_tree
      in_wget: in_wget
    out:
      [
        OUT_dir,
        OUT_gunzip
      ]
#  apollo2:
#    run: flow_apollo2/apollo2-workflow.cwl
#    in: 
#      in_tree: in_tree
#      in_dir: setup/OUT_dir
#      in_gff: setup/OUT_genomic_gff
#      in_fasta: setup/OUT_genomic_fasta
#    out:
#      []

outputs:
  final_dir:
    type: Directory
    outputSource: setup/OUT_dir
  final_gunzip:
    type: File[]
    outputSource: setup/OUT_gunzip
