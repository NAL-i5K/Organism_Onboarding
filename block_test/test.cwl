#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.dir)

baseCommand: [mkdir]
arguments: ['-p', $(inputs.dir.listing.[basename])]

inputs:
  dir:
    type: Directory

outputs:
  out:
    type: Directory[]
    outputBinding:
      glob: '*'
