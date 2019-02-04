#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir)];
        return LIST;
      }

baseCommand: [generate-names.pl]
arguments: 
  - position: 1
    prefix: --verbose
  - position: 3
    prefix: --out
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/
#  - position: 1
#    prefix: --tracks
#    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/tracks/$(inputs.in_tree[0])_current_models
    
inputs:
  in_dir:
    type: Directory 
  in_tree:
    type: string[]
  in_tracks:
    type: Directory
outputs:
  out_names:
    type: Directory
    outputBinding: 
      glob: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/names
