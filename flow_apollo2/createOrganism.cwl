#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [createOrganism.py]
arguments: 
  - position: 1
    prefix: -host
    valueFrom: https://apollo-dev.nal.usda.gov
  - position: 3
    prefix: -organism
    valueFrom: $(inputs.in_tree[2].split('_')[0]) $(inputs.in_tree[2].split('_')[1])
  - position: 5
    prefix: -genus
    valueFrom: $(inputs.in_tree[2].split('_')[0])
  - position: 7
    prefix: -species
    valueFrom: $(inputs.in_tree[2].split('_')[1])
  - position: 9
    prefix: -directory
    valueFrom: /app/data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 11
    prefix: -blatdb
    valueFrom: data/blat/db/$(inputs.in_tree[0])/$(inputs.in_2bi.basename)
  - position: 13
    valueFrom: -publicMode

inputs:
  in_tree:
    type: string[]
  in_2bi:
    type: File

outputs: []
