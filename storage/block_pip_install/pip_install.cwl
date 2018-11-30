#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [pip, install]

inputs: 
  in_pip_install:
    type: string[]
    inputBinding:
      position: 1

outputs: []
