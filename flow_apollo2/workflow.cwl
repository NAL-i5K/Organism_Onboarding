#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_gff: File
  in_fasta: File

steps:
  setup_folder:
    run: tree.cwl
    in: []
    out:
      [out_dir]
  processing:
    run: processing/workflow.cwl
    in:
      in_tree: in_tree
      in_gff: in_gff
      in_fasta: in_fasta
    out:
      [
        
      ]
  wrapping:
    run: wrapping/workflow.cwl
    in:      
    out:

outputs: 
  OUT_dir:
    type: Directory
    outputSource: setup_folder/out_dir
     
