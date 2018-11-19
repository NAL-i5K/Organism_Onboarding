#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - entry: $(inputs.in_gunzip)
        writable: true

baseCommand: [gzip]

inputs:
  in_gunzip:
    type: File
    inputBinding:
      position: 1     
      prefix: -d
      valueFrom: $(self.basename)

outputs: 
  out_gunzip:
    type: File
    outputBinding:
      glob: '*'
