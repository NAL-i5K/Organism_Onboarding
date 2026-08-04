#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [../content_onboarding_scripts/bin/add_ontology_terms_from_gaf_gmt.pl]
arguments:
  - position: 7
    valueFrom: $(inputs.output_name)

inputs:
  in_GO:
    type: File
    inputBinding:
      prefix: --gaf
      position: 1
  in_PathAnnotatorGMT:
    type: File
    inputBinding:
      prefix: --gmt
      position: 2
  in_gff:
    type: File
    inputBinding:
      prefix: --gff
      position: 3
  annotate_egap:
    type: boolean?
    default: false
    inputBinding:
      prefix: --egap
      position: 4
  annotate_cds:
    type: boolean?
    default: false
    inputBinding:
      prefix: --cds
      position: 5
  output_name:
    type: string
    default: $(inputs.in_gff.nameroot).annotated.gff
    inputBinding:
      prefix: --out
      position: 6
outputs:  
  processed_gff:
    type: File
    outputBinding:
      glob: $(inputs.output_name)
    
 
