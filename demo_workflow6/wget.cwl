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
  out_wget_gz:
    type: File[]
    outputBinding:
      glob: '*.gz'

  out_wget_txt:
    type: File
    outputBinding:
      glob: '*.txt'
    
