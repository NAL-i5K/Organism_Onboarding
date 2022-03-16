#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = [(inputs.in_fasta)];
        return LIST;
      }

baseCommand: [python]
arguments:
  - position: 1
    valueFrom: $(inputs.managePy_Path)manage.py
  - position: 2
    prefix: addhmmer
    valueFrom: $(inputs.scientific_name[0])
  - position: 3
    valueFrom: $(inputs.scientific_name[1])
  - position: 4
    prefix: -f
    valueFrom: $(inputs.in_fasta.basename)
  - position: 5
    prefix: -d
    valueFrom: $(inputs.scientific_name[0]) $(inputs.scientific_name[1]) $(inputs.tree[2]), peptides

inputs:
  in_dummy:
    type: File
  scientific_name:
    type: string[]
  tree: 
    type: string[]
  managePy_Path:
    type: string
  in_fasta:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: addhmmer.dummy
    
