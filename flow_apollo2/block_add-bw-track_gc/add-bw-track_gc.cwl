#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gc_bigwig),
                    (inputs.in_dir)];
        return LIST;
      }

baseCommand: [add-bw-track.pl]
arguments: 
  - position: 1
    prefix: --pos_color
    valueFrom: "rgba(0,0,255,50)"
  - position : 3
    prefix: --neg_color
    valueFrom: "rgba(255,255,0,50)"
  - position: 5
    prefix: --bicolor_pivot
    valueFrom: "0.5"
  - position: 7
    prefix: --label
    valueFrom: "GC Content"
  - position: 9
    prefix: --bw_url 
    valueFrom: $(inputs.in_gc_bigwig.basename)
  - position: 11
    prefix: --in
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json

inputs:
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_gc_bigwig:
    type: File

outputs:
  out_trackList_json:
    type: File
    outputBinding:
      glob: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json
