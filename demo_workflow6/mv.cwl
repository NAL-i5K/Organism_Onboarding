#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_mv_dir)&&$(inputs.in_mv_file)
#        writable: true #Default: Read-only Dir

baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_mv_file[1].basename)
  - position: 2
    valueFrom: $(inputs.in_mv_dir.basename)

inputs: 
  in_mv_dir:
    type: Directory
  in_mv_file:
    type: File[]
   
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: '*'
