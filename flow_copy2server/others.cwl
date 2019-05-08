#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = inputs.in_others;
        LIST.push(inputs.in_dir);
        return LIST;
      }
baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_others)
  - position: 2
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/$(inputs.in_tree[2])/

inputs: 
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_others:
    type: File[]
      
outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.in_dir.basename)/ 
