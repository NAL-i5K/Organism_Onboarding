#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var listing = inputs.in_mv_files;
        listing.push(inputs.in_mv_dir); 
        return listing; 
      }
baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: 
      ${
        var LIST = (inputs.in_mv_files);
        for(var i=0; i<LIST.length; i++) {
          if(LIST[i].nameext == '.txt')
            return LIST[i].basename;
        }
      }
  - position: 2
    valueFrom: $(inputs.in_mv_dir.basename)

inputs: 
  in_mv_dir:
    type: Directory
  in_mv_files:
    type: File[]
      
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: $(inputs.in_mv_dir.basename)
