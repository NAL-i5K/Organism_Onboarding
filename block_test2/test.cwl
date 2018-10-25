#!/usr/bin/env cwl-runner

# a test for 
# How to parse thing in listing if I pass a directory to inputs section

# equivalent linux command:
# echo XX > YY 

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir)
        #${return {'type': 'array', 'items': 'File'};}
        writable: true

baseCommand: [echo]
arguments: [$(inputs.dir.listing)]

inputs:
  dir:
    type: Directory
  in_file:
    type: File
outputs: 
  out:
    type: stdout
stdout: hello.txt
#outputs:
#  out:
#    type: File
#    outputBinding:
#      glob: '*'
