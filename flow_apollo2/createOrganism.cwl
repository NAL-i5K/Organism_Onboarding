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

baseCommand: [createOrganism.py]
arguments: 
  - position: 1
    prefix: -publicMode -host
    valueFrom: https://apollo-dev.nal.usda.gov
  - position: 3
    prefix: -organism
    valueFrom: $(inputs.in_tree[2].split('*')[0])
  - position: 5
    prefix: -genus
    valueFrom: $(inputs.in_tree[2].split('*')[0])
  - position: 7
    prefix: -species
    valueFrom: $(inputs.in_tree[2].split('*')[0])

inputs:
  in_tree:
    type: string[]
outputs:
  out_names:
    type: Directory
    outputBinding: 
      glob: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/names
