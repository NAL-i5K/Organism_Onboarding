#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - entry: $(inputs.in_gunzip)
        writable: true

baseCommand: [gzip]

inputs:
  in_gunzip:
    type: File[]
    inputBinding:
      position: 1     
      valueFrom: $(self[0].basename)
      prefix: -d

# arguments section is alternative way to implement the -d, but it is nicer to write in inputs section instead of arguments section
# arguments: ['-d', $(inputs.in_gunzip.listing)]  
# $(inputs.in_gunzip.listing) return string[], which include all the files and subdirectories inside in_gunzip

outputs: 
  out_gunzip:
    type: File[]
    outputBinding:
      glob: ['*']
      #glob: $(inputs.in_gunzip.basename)

