#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [touch]

inputs: []
arguments:
  - position: 1
    valueFrom: readme.txt

outputs:
  readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
