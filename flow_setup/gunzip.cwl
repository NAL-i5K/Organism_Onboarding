#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
#  - class: InitialWorkDirRequirement
#    listing: 
#      - entry: $(inputs.dir_gunzip)
    #    writable: true

baseCommand: [gzip]

inputs:
  in_gunzip:
    type: Directory
    inputBinding:
      position: 1     
      valueFrom: $(self.listing) #self = inputs.in_gunzip
      prefix: -d

# arguments section is alternative way to implement the -d, but it is nicer to write in inputs section instead of arguments section
# arguments: ['-d', $(inputs.dir_gunzip.listing)]  
# $(inputs.dir_gunzip.listing) return string[], which include all the files and subdirectories inside dir_gunzip

outputs: []
#  out_gunzip:
#    type: Directory
#    outputBinding:
      #glob: $(inputs.dir_gunzip.basename)

