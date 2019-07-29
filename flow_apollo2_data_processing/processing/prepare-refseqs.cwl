#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_fasta), 
                    (inputs.in_fai) ];
        return LIST;
      }

baseCommand: [prepare-refseqs.pl]
arguments: 
  - position: 1
    prefix: --indexed_fasta
    valueFrom: $(inputs.in_fasta.basename)
  - position: 3
    prefix: --out
    valueFrom: data/
    
inputs:
  in_fasta:
    type: File
  in_fai:
    type: File

outputs: 
  out_trackList_json:
    type: File
    outputBinding: 
      glob: 'data/trackList.json'
  out_seq:
    type: Directory
    outputBinding: 
      glob: 'data/seq/'
  out_tracks_conf:
    type: File
    outputBinding: 
      glob: 'data/tracks.conf'
