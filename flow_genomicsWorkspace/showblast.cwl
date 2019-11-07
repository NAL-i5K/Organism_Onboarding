#!/usr/bin/env cwl-runner

cwlVersion: v1.0
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
    prefix: blast_shown
    valueFrom: $(inputs.in_fasta.basename)
  - position: 3
    prefix: --shown
    valueFrom: 'true'

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
stdout: showblast.dummy
    
