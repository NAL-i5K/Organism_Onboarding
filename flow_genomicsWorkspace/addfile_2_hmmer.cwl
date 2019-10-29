#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_fasta)

baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_fasta.basename)
  - position: 2
    valueFrom: /home/vagrant/genomics-workspace/media/hmmer/db 

inputs:
  in_fasta:
    type: File

outputs:
  out_dummy:
    type: stdout
stdout: addfile_2_hmmer.dummy
