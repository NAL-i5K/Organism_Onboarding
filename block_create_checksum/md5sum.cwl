#!/usr/bin/env cwl-runner

# equivalent linux command:
# find -type f -exec md5sum {} \; > md5sum.txt 

cwlVersion: v1.0
class: CommandLineTool
label: find file, and execute md5sum, then output a txt file

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in)
        #entryname: inputDir
        writable: true #Default: Read-only Dir

baseCommand: [find]
arguments: ['-type', f, '-exec', md5sum, '{}', ;]

inputs: 
  in:
    type: Directory

outputs:
  report:
    type: stdout
#stdout: $(inputs.in.location)
stdout: md5sum.txt

  #out:
  #  type: File
  #  outputBinding:
  #    glob: '*'
