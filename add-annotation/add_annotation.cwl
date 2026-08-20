#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [add_ontology_terms_from_gaf_gmt.pl]
arguments:
  - position: 6
    valueFrom: $(inputs.in_gff.nameroot + ".annotated.gff3")

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
outputs:  
  processed_gff:
    type: File
    outputBinding:
      glob: "*.annotated.gff3"
    
 
