#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_move_file)
        writable: true
      - entry: $(inputs.in_move_dir)
        writable: true

baseCommand: [mv]

inputs:
  in_move_file:
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
      
  in_move_dir:
    type: Directory
    inputBinding:
      position: 2
      valueFrom: $(self.basename)

outputs: []

