#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:

steps:
  step_gap2bigwig:
    run: block_gap2bigwig/gap2bigwig.cwl
    in:
      in_fasta: in_fasta
      in_gap2bigwig: in_gap2bigwig
    out: 
      [out_fasta_diff_match] 
  step_GCcontent2bigwig:
    run: block_GCcontent2bigwig/GCcontent2bigwig.cwl
    in:
      in_files: in_files
    out: 
      [out_gff3_sort] 
  
outputs: []
#  final_update_gff_updated:
#    type: File
#    outputSource: step_update_gff/out_update_gff_updated
