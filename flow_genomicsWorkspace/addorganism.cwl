#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

#requirements:

baseCommand: [python]
arguments:
  - position: 1
    valueFrom: $(inputs.managePy_Path)manage.py
  - position: 2
    prefix: addorganism
    valueFrom: $(inputs.scientific_name[0])
  - position: 3
    valueFrom: $(inputs.scientific_name[1])

inputs:
  scientific_name:
    type: string[]
  managePy_Path:
    type: string
  in_dummy:
    type: File
outputs:  
  out_dummy:
    type: stdout
stdout: addOrganism.dummy
    
 
