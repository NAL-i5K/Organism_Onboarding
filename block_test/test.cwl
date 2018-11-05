#!/usr/bin/env cwl-runner

# equivalent linux command:
# touch file (name is based on file inside the input dir)

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
#  - class: InitialWorkDirRequirement
#    listing:
#      - entry: $(inputs.in_dir)
        #entryname: sample
#        writable: true

baseCommand: [touch]
arguments: 
  - valueFrom: 
      ${
        var x = (inputs.in_dir.listing);
        var y = [];
        for (var i=0; i<x.length; i++) {
          if (x[i].nameext == '.log') {
            y = x[i].nameroot;
          }
        }
        return y;
      }

inputs:
  in_dir:
    type: Directory

outputs:
  out:
    type: File
    outputBinding:
      glob: '*'
