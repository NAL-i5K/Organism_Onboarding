#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_md5sum_check)
 # writable: true ??

baseCommand: [md5sum]
 
inputs: 
  in_md5sum_check:
    type: File[]
    inputBinding:
      position: 1
      prefix: -c
      valueFrom:
        ${
          for (var i = 0; i <= self.length; i++) {
            if (self[i].nameext == '.txt') {
              return self[i].basename;
            }    
          }
        }

outputs: 
  out_md5sum_check:
    type: stderr
stderr: 
  ${
    var inp = (inputs.in_md5sum_check);
    for (var i = 0; i <= inp.length; i++) {
      if (inp[i].nameext == '.txt') {
        return inp[i].nameroot + '.log';
      }    
    }
  }
