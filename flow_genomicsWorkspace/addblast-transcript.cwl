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

baseCommand: [/home/vagrant/genomics-workspace/manage.py]
arguments:
  - position: 1
    prefix: addblast
    valueFrom: $(inputs.scientific_name[0])
  - position: 2
    valueFrom: $(inputs.scientific_name[1])
  - position: 3
    prefix: -t
    valueFrom: nucleotide
  - position: 4
    valueFrom: Transcript
  - position: 5
    prefix: -f
    valueFrom: $(inputs.in_fasta.basename)

inputs:
  scientific_name:
    type: string[]
  in_fasta:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: addblast.dummy
    
