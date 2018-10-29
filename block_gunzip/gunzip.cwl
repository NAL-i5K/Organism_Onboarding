#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir_gunzip)
        writable: true

baseCommand: [gzip]

inputs:
  dir_gunzip:
    type: Directory
    inputBinding:
      position: 1     valueFrom: $(self.listing)
      prefix: -d

# arguments section is alternative way to implement the -d, but it is nicer to write in inputs section instead of arguments section
# arguments: ['-d', $(inputs.dir_gunzip.listing)]  
# $(inputs.dir_gunzip.listing) return string[], which include all the files and subdirectories inside dir_gunzip

outputs: 
  out_gunzip:
    type: Directory
    #streamable: true
    outputBinding:
      glob: $(inputs.dir_gunzip.basename)
      #glob: '*'

#stdout: $(inputs.dir_gunzip.basename)
