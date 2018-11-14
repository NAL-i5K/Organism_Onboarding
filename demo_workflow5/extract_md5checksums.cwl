#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        return inputs.in_extract_md5checksums;
      } 
        #writable: true

baseCommand: [egrep]
arguments: 
  - position: 1
    valueFrom: 
      ${
        var LIST = inputs.in_extract_md5checksums;
        var A = [];
        for (var i = 0; i < LIST.length; i++) {
           if ((LIST[i].class == 'File') && (LIST[i].nameext == '.gz')) {
             A.push(LIST[i].basename);
           }
        }
        var B = [];
        for (var i = 0; i < A.length; i++) {
          B = B + A[i];
          if(i != A.length-1) {
            B = B + '|';
          }
        }
        return B;
      }
  - position: 2
    valueFrom: 
      ${
        var LIST = inputs.in_extract_md5checksums;
        for (var i = 0; i < LIST.length; i++) {
           if ((LIST[i].class == 'File') && (LIST[i].nameext == '.txt')) {
             return LIST[i].basename;
           }
        }
      }
inputs: 
  in_extract_md5checksums:
    type: File[]

outputs: 
  out_extract_md5checksums:
    type: stdout
stdout: md5checksums.txt2
