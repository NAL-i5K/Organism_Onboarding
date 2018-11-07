#!/usr/bin/env cwl-runner

# equivalent linux command:
# find -type f -exec md5sum {} \; > md5sum.txt 

cwlVersion: v1.0
class: CommandLineTool
label: find file, and execute md5sum, then output a txt file

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_md5sum_create)
        #entryname: inputDir
        #writable: true #Default: Read-only Dir

#baseCommand: [find]
#arguments: ['-type', f, '-exec', md5sum, '{}', ;]
baseCommand: [md5sum]

inputs: 
  in_md5sum_create:
    type: File[]
    inputBinding:
      position: 1
      valueFrom: $(self)
#      below is code with same effect :
#      valueFrom: 
#        ${
#          var x = [];
#          for (var i=0; i<self.length; i++) {
#            x[i] = (self[i].basename);
#          }
#          return x;
#        }

outputs:
  out_md5sum_create:
    type: stdout
stdout: md5checksums_create.txt
