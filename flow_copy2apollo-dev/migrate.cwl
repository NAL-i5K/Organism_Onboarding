#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_dir)

baseCommand: [echo]
arguments:
  - position: 1
    valueFrom: "Finish copy data from one place to another!!"

inputs: 
  in_dir:
    type: Directory
      
outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: data
