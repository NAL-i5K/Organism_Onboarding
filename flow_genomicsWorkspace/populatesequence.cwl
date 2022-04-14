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
    prefix: blast_utility
    valueFrom: $(inputs.in_fasta.basename)
  - position: 3
    valueFrom: -p

inputs:
  in_dummy:
    type: File
  managePy_Path:
    type: string
  in_fasta:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: populatesequence.dummy
    
