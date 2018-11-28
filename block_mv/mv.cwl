#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_mv)
      #- entry: $(inputs.in_file)
baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_mv.basename)/apple
  - position: 2
    valueFrom: $(inputs.in_mv.basename)/data/

inputs: 
  in_mv:
    type: Directory
  in_file:
    type: File[]
      
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: '*'
