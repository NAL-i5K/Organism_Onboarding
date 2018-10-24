#!/usr/bin/env cwl-runner

# a test for 
# gzip -d *.gz

# equivalent linux command:
# touch file (name is based on file inside the input dir)


cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir)
#        ${return {'type': 'array', 'items': 'File'};}
        #entryname: sample
        writable: true

baseCommand: [touch]
arguments: [$(inputs.dir.listing.'orange')]

inputs:
  dir:
    type: Directory

outputs:
  out:
    type: stdout
stdout: $(inputs.dir.listing.'orange')

#outputs:
#  out:
#    type: File
#    outputBinding:
#      glob: '*'
