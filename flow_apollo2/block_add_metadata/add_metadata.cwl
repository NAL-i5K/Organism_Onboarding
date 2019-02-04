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

baseCommand: [add_metadata_to_GC_gap_bigwig_tracks.pl]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json
  - position: 3
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json.bak-metadata
  - position : 5
    valueFrom: $(inputs.in_fasta.basename).gc.bigwig
  - position : 7
    valueFrom: $(inputs.in_fasta.basename).gaps.bigwig
    
inputs:
  in_tree:
    type: string[]
  in_dir:
    type: Directory
  in_fasta:
    type: File
  in_trackList_json:
    type: File

outputs: [] 
#  out_GCcontent2bigwig:
#    type: File
#    outputBinding: 
#      glob: '*.gc.bigwig'
