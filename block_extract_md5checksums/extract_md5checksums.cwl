#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_dir)
        #entryname: inputDir
        writable: true #Default: Read-only Dir

baseCommand: [egrep]
arguments: 
  - position: 1
    valueFrom: 
      ${
        var A = [];
        for (var i = 0; i < inputs.in_dir.listing.length; i++) {
           if (inputs.in_dir.listing[i].nameext == '.gz') {
             A.push(inputs.in_dir.listing[i].basename);
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

inputs: 
  in_dir:
    type: Directory
    inputBinding:
      position: 2
      valueFrom:
        ${
          for (var i = 0; i < self.listing.length; i++) {
            if (self.listing[i].nameext == '.txt') {
              return self.basename + '/' + self.listing[i].basename;
            }    
          }
        }  

outputs: 
  out_extract_md5checksums:
    type: stdout
stdout: md5checksums.txt2 
