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
    prefix: addblast
    valueFrom: $(inputs.scientific_name[0])
  - position: 3
    valueFrom: $(inputs.scientific_name[1])
  - position: 4
    prefix: -t
    valueFrom: nucleotide
  - position: 5
    valueFrom: Transcript
  - position: 6
    prefix: -f
    valueFrom: $(inputs.in_fasta.basename)

inputs:
  scientific_name:
    type: string[]
  managePy_Path:
    type: string
  in_fasta:
    type: File
  in_dummy:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: addblast.dummy
    
