#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
#  - class: LoadListingRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - $(inputs.in_dir)

baseCommand: [cp, -r]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])
  - position: 2
    valueFrom: /app/data/other_species/

inputs: 
  in_dir:
    type: Directory
  in_tree:
    type: string[]
      
outputs: [] 
