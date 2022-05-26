#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

baseCommand: [add_GO-KEGG_to_RefSeq-gff.pl]
arguments:
  - position: 1
    valueFrom: $(inputs.in_GO)
  - position: 2
    valueFrom: $(inputs.in_KEGG)
  - position: 3
    valueFrom: $(inputs.in_gff)
  - position: 4
    valueFrom: $(inputs.in_table)

inputs:
  in_GO:
    type: File
  in_KEGG:
    type: File
  in_gff:
    type: File
  in_table:
    type: File
outputs:  
  processed_gff:
    type: stdout
stdout: $(inputs.in_gff.nameroot).annotated.gff
    
 
