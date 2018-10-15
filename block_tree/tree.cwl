#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [mkdir, -p]

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.info)

inputs:
  info:
    type: string[]
    inputBinding:
      position: 1
      valueFrom: $(self.basename)

outputs:
  example_out:
    type: Directory[]
    outputBinding:
      glob: "*"

