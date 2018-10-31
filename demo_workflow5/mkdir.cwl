#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

baseCommand: [mkdir]

arguments: ['data']

inputs: []
#  in_mkdir:
#    type: string
#    inputBinding:
#      position: 1
      #prefix: -p

outputs:
  out_mkdir:
    type: Directory
    outputBinding:
      glob: '*'

