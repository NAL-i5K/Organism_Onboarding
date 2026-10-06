#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  LoadListingRequirement:
    loadListing: no_listing
baseCommand: [cp, -r, -T]
arguments:
  - position: 1
    valueFrom: $(decodeURIComponent(inputs.in_data.location.slice(7)))
  - position: 2
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_1[0])/$(inputs.deepPATH_2[0])/$(inputs.in_data.basename)
inputs:
  PATH: string[]
  tree: string[]
  deepPATH_1: string[]
  deepPATH_2: string[]
  in_data: Directory
outputs: []
