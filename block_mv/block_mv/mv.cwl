#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_mv)
        writable: true #Default: Read-only Dir

baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_mv.basename)/apple
  - position: 2
    valueFrom: $(inputs.in_mv.basename)/data/

# $(inputs.dir) = /tmp/tmpABCD/data
# $(inputs.dir.dirname) = /tmp/tmpABCD/
# $(inputs.dir.basename) = data/
# $(inputs.dir.listing) = return string[]
#  
# $(inputs.in_file) = /tmp/tmpABCD/filename.txt
# $(inputs.in_file.basename) = filename.txt
# 
inputs: 
  in_mv:
    type: Directory
      
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: '*'
