#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(arguments)

baseCommand: [gzip, -cd]

inputs: []

arguments: [apple.gz]  
#  - valueFrom: $(inputs.in)

#outputs: 
#  out:
#    type: File[]
#    streamable: true
#    outputBinding:
#      glob: '*'

outputs:
  out:
    type: stdout
stdout: '*'
