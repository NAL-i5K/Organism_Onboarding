#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: run md5sum

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in)
        writable: true #Default: Read-only Dir

baseCommand: [find]
arguments: ['-type', f, '-exec', md5sum, '{}', ;]

inputs: 
  in:
    type: Directory

outputs: 
  [] 
  #out:
  #  type: File
  #  outputBinding:
  #    glob: '*'
