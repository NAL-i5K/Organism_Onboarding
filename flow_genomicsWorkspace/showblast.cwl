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
    prefix: blast_shown
    valueFrom: $(inputs.in_fasta.basename)
  - position: 2
    prefix: --shown
    valueFrom: 'true'

inputs:
  in_dummy:
    type: File
  in_fasta:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: showblast.dummy
    
