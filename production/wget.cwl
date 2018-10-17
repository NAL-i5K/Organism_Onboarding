
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wget]
inputs:
  in_strings:
    type: string[]
    inputBinding:
      position: 1
outputs:
  out:
    type: File[]
    outputBinding:
      glob: '*'

