#!/usr/bin/env cwl-runner

# equivalent linux command:
# md5sum -c md5checksums.txt &> check.log

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_md5sum_check)
        writable: true

baseCommand: [md5sum]
#arguments: ['-c', $(inputs.dir.dirname)/$(inputs.dir.basename)/$(inputs.in_file.basename)]

# $(inputs.dir) = /tmp/tmpABCD/data
# $(inputs.dir.dirname) = /tmp/tmpABCD/
# $(inputs.dir.basename) = data/
# $(inputs.dir.listing) = return string[]
#  
# $(inputs.in_file) = /tmp/tmpABCD/filename.txt
# $(inputs.in_file.basename) = filename.txt
# 
inputs: 
  in_md5sum_check:
    type: File[]
    inputBinding:
      position: 1
      prefix: -c
      valueFrom: 'md5checksums.txt'      

outputs: 
  out_md5sum_check:
    type: stderr
stderr: check.log

