#!/usr/bin/env cwl-runner

# a test for 
# cd

# equivalent linux command:

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [cd]

inputs:
  dir:
    type: Directory
    inputBinding: 
      position: 1
      valueFrom: $(self.basename)

outputs: []
#  out:
#    type: stdout
#stdout: $(inputs.dir)

#outputs:
#  out:
#    type: File
#    outputBinding:
#      glob: '*'
