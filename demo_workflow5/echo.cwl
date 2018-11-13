#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
#  - class: InitialWorkDirRequirement
#    listing:
#      - entry: $(inputs.in_grep)
        #entryname: inputDir
        #        #writable: true
        #


baseCommand: [echo]
arguments:
  - position: 1
    valueFrom: $(inputs.in_echo.basename)

inputs:
  in_echo: 
    type: File

outputs: []
