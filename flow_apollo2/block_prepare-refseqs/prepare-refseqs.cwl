#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir), 
                    (inputs.in_fasta), 
                    (inputs.in_fai), ];
        return LIST;
      }

baseCommand: [prepare-refseqs.pl]
arguments: 
  - position: 1
    prefix: --indexed_fasta
    valueFrom: $(inputs.in_fasta.basename)
  - position: 3
    prefix: -o
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
    
inputs:
  in_dir:
    type: Directory 
  in_tree:
    type: string[]
  in_fasta:
    type: File
  in_fai:
    type: File

outputs: 
  out_trackList_json:
    type: File
    outputBinding: 
      glob: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data/trackList.json
