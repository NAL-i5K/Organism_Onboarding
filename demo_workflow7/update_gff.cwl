#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $([inputs.in_update_gff_from_fasta_diff, inputs.in_update_gff_from_gff3_sort])

baseCommand: [update_gff]
arguments: 
  - position: 1
    prefix: -a
    valueFrom: $(inputs.in_update_gff_from_fasta_diff.basename)
  - position: 2
    valueFrom: $(inputs.in_update_gff_from_gff3_sort.basename)

inputs: 
  in_update_gff_from_fasta_diff:
    type: File
  in_update_gff_from_gff3_sort:
    type: File

outputs:
  out_update_gff_updated:
    type: File
    outputBinding:
      glob: '*_updated.*'
