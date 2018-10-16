#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [gzip, -d]

inputs: 
  in:
    type: File

arguments:
  - valueFrom: $(inputs.in.path)

outputs: 
  out:
    type: File
    streamable: true
    outputBinding:
      glob: 'hello'
stdout: 'hello'
