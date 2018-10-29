#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_rename)
        writable: true #Default: Read-only Dir

baseCommand: [mv]
arguments:
  - position: 2
    valueFrom: rename_output.gz

inputs: 
  in_rename:
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
#  in_rename_2:
#    type: string
#    inputBinding:
#      position: 2
     # valueFrom: $(inputs.in_rename.nameroot)

outputs: 
  out_rename:
    type: File[]
    outputBinding:
      glob: '*'
