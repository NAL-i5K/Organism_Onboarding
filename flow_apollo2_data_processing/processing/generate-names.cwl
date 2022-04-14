#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_data)];
        return LIST;
      }

baseCommand: [generate-names.pl]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    prefix: --verbose
  - position: 3
    prefix: --out
    valueFrom: data/
    
inputs:
  in_data:
    type: Directory
  in_tracks:
    type: Directory
outputs:
  out_names:
    type: Directory
    outputBinding: 
      glob: data/names
