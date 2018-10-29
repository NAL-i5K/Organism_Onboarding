#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dir)
        #entryname: inputDir
        writable: true #Default: Read-only Dir
      - entry: $(inputs.in_file)
        writable: true

baseCommand: [md5sum]
arguments: ['-c', $(inputs.dir.dirname)/$(inputs.dir.basename)/$(inputs.in_file.basename)]
# $(inputs.dir) = /tmp/tmpABCD/data
# $(inputs.dir.dirname) = /tmp/tmpABCD/
# $(inputs.dir.basename) = data/
# $(inputs.dir.listing) = return string[]
#  
# $(inputs.in_file) = /tmp/tmpABCD/filename.txt
# $(inputs.in_file.basename) = filename.txt
# 
inputs: 
  dir:
    type: Directory
  in_file:
    type: File
#    inputBinding:
#      position: 1
#      prefix: -c

outputs: 
  report:
    type: stderr
stderr: check-fake.log

  #out:
  #  type: File
  #  outputBinding:
  #    glob: '*'
