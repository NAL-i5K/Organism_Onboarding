#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir), 
                    (inputs.in_jbrowse)];
        return LIST;
      }

baseCommand: [generate-names.pl]
arguments: 
  - position: 1
    prefix: --tracks
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/tracks/$(inputs.in_tree[0])_current_models
  - position: 3
    prefix: --verbose
  - position: 5
    prefix: --out
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/
    
inputs:
  in_dir:
    type: Directory 
  in_tree:
    type: string[]
  in_jbrowse:
    type: Directory

outputs: []
