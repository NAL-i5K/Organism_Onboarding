#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [mkdir, -p]
requirements:
  - class: InlineJavascriptRequirement
#  - class: InitialWorkDirRequirement
    #listing: $(inputs.in)

inputs:
  in:
    type: string[]
    inputBinding:
      position: 1
      #valueFrom: $(self.basename)

outputs:
  out:
    type: Directory[]
    outputBinding:
      glob: "*"

