#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: [git, clone]

inputs: 
  in_gitclone:
    type: string
    inputBinding:
      position: 1
#      prefix: -c

outputs: 
  out_gitclone:    
    type: Directory
    outputBinding:
      glob: '*'

