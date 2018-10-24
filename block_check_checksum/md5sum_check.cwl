#!/usr/bin/env cwl-runner

# equivalent linux command:
# md5sum -c md5checksums.txt &> check.log

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in)
        #entryname: inputDir
        writable: true #Default: Read-only Dir
      - entry: $(inputs.in_file)
        writable: true

baseCommand: [md5sum]
arguments: ['-c', $(inputs.in.dirname)/$(inputs.in.basename)/$(inputs.in_file.basename)]
# -c tmp/tmp.../data/md5checksums.txt
# inputs.in.basename = data


inputs: 
  in:
    type: Directory
  in_file:
    type: File
#    inputBinding:
#      position: 1
#      prefix: -c

outputs:
  report:
    type: stderr
stderr: check.log

  #out:
  #  type: File
  #  outputBinding:
  #    glob: '*'
