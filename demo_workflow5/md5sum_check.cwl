#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var A = inputs.in_md5sum_check_from_wget;
        A.push(inputs.in_md5sum_check_from_extract);
        return A;
      }
 # writable: true ??

baseCommand: [md5sum]
 
inputs: 
  in_md5sum_check_from_wget:
    type: File[]
  
  in_md5sum_check_from_extract:
    type: File
    inputBinding:
      prefix: -c
      position: 1
      valueFrom: $(self.basename)

outputs: 
  out_md5sum_check:
    type: stdout
stdout: md5checksums.log
