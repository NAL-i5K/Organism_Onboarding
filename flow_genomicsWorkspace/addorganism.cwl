#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

#requirements:

baseCommand: [/home/vagrant/genomics-workspace/manage.py]
arguments:
  - position: 1
    prefix: addorganism
    valueFrom: $(inputs.scientific_name[0])
  - position: 2
    valueFrom: $(inputs.scientific_name[1])

inputs:
  scientific_name:
    type: string[]
outputs:
  out_dummy:
    type: stdout
stdout: addOrganism.dummy
    
 
