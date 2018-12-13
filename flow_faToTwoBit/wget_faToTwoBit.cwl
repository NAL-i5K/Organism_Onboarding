#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [wget]
arguments: 
  - position: 1
    valueFrom: "http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/faToTwoBit"

inputs: []

outputs: 
  out_wget_faToTwoBit:
    type: File
    outputBinding:
      glob: '*'
