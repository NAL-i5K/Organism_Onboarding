#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "command line: gunzip"

requirements:
  - class: InlineJavascriptRequirement

inputs:

  - id: input
    type: File
    inputBinding:
      position: 0

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.input.path.split("/").slice(-1)[0].split(".").slice(0,-1).join("."))

baseCommand: [gunzip, -c]
stdout: $(inputs.input.path.split("/").slice(-1)[0].split(".").slice(0,-1).join("."))
