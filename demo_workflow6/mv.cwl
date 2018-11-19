#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: 
          ${
            var R = [];
            R = [inputs.in_mv_dir];
            return R;
          }

       # var R = new Array(inputs.in_mv_gitclone, inputs.in_mv_dir);
baseCommand: [mv]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_mv_dir.basename)
  - position: 2
    valueFrom: apple

# $(inputs.dir) = /tmp/tmpABCD/data
# $(inputs.dir.dirname) = /tmp/tmpABCD/
# $(inputs.dir.basename) = data/
# $(inputs.dir.listing) = return string[]
inputs: 
  in_mv_dir:
    type: Directory
  in_mv_file:
    type: File[]
  in_mv_gitclone:
    type: Directory[]  
 
outputs: 
  out_mv:
    type: Directory
    outputBinding:
      glob: apple
