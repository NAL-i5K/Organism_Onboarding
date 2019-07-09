#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_dir)

baseCommand: [cp]
arguments:
  - prefix: -r
    position: 1
    valueFrom: $(inputs.in_dir.basename)/*
  - position: 3
    valueFrom: $(inputs.PATH[0])/
      
inputs:
  PATH:
    type: string[]
  in_dir:
    type: Directory

outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.in_dir.basename)/

