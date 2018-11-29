#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget]

inputs:
  in_wget:
    type: string[]
    inputBinding:
      position: 1

outputs: 
  out_wget:
    type: File[]
    outputBinding:
      glob: ['*']
    

