#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  
baseCommand: [cp]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    prefix: -r
    valueFrom: $(inputs.in_data.location.slice(7))
  - position: 3
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH[0])/

inputs: 
  PATH:
    type: string[]
  tree:
    type: string[]
  deepPATH:
    type: string[]
  in_data:
    type: Directory

outputs: []
