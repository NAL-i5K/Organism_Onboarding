#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.current_dir)
        writable: true

baseCommand: [gzip]

inputs:
#  in_wget:
#    type: string[] 
  current_dir:
    type: Directory

arguments: ['-d', gzfile/$(inputs.current_dir.listing.basename)]  
#  - valueFrom: $(inputs.current_dir)

outputs: 
  out:
    type: File[]
    #streamable: true
    outputBinding:
      glob: $(inputs.current_dir.listing.nameroot)
stdout: $(inputs.current_dir.listing.nameroot)
