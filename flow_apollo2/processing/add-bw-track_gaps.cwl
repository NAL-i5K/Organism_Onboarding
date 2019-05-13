#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir),
                    (inputs.in_gaps_bigwig)];
        return LIST;
      }

baseCommand: [add-bw-track.pl]
arguments: 
  - position: 1
    prefix: --pos_color
    valueFrom: "black"
  - position : 3
    prefix: --neg_color
    valueFrom: "white"
  - position: 5
    prefix: --label
    valueFrom: "Gaps in assembly"
  - position: 7
    prefix: --bw_url 
    valueFrom: bigwig/$(inputs.in_gaps_bigwig.basename)
  - position: 9
    prefix: --in
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json
    
inputs:
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_gaps_bigwig:
    type: File
  in_trackList_json:
    type: File

outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.in_dir.basename)/
  out_trackList_json:
    type: File
    outputBinding: 
      glob: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json
