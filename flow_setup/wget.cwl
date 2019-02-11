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
  out_md5checksums_txt:
    type: File
    outputBinding:
      glob: ['md5checksums.txt']
  out_gz:
    type: File[]
    outputBinding:
      glob: ['*.gz']
    

