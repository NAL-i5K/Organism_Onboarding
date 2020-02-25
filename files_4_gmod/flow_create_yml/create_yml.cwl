#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [touch]

inputs: []
arguments:
  - position: 1
    valueFrom: genomics-workspace.yml

outputs:
  Yml_file:
    type: File
    outputBinding:
      glob: "*.yml"
