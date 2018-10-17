#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.in)

baseCommand: [echo]

inputs: 
  in:
    type: File
    inputBinding:
      position: 1

#arguments: [a1, a2, a3] 
#  - valueFrom: $(inputs.in.path)

outputs: 
  out:
    type: File[]
#    streamable: true
    outputBinding:
      glob: '*'
#stdout: '*'
