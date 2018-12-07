#!/usr/bin/env cwl-runner

cwlVersion: v1.0
$graph:
- id: fasta_diff
  class: CommandLineTool
  inputs:
    in_files:
      type: File[]
  outputs: 
    out_fasta_diff_report:
      type: File
      outputBinding:
        glob: '*.txt'
    out_fasta_diff_match:
      type: File
      outputBinding:
        glob: '*.tsv'
  baseCommand: [fasta_diff]
  arguments: 
    - position: 1
      valueFrom: 'old.fa'
    - position: 2
      valueFrom: 'new.fa' 
    - position: 3
      prefix: -o
      valueFrom: 'match.tsv'
    - position: 4
      prefix: -r
      valueFrom: 'report.txt'

- id: main
  class: Workflow
  requirements:
    - class: MultipleInputFeatureRequirement
  inputs: 
    in_files: File[]
  outputs:
    - id: final_fasta_diff
      type: File
      outputSource: step_fasta_diff/out_fasta_diff_match
  steps:
    step_fasta_diff:
      run: "#fasta_diff"
      in:
         in_files: in_files
      out: [out_fasta_diff_match]

