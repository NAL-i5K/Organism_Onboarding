#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gff)];
        return LIST;
      }

baseCommand: [flatfile-to-json.pl]
arguments: 
  - position: 1
    prefix: --gff
    valueFrom: $(inputs.in_gff.basename)
  - position: 3
    prefix: --arrowheadClass
    valueFrom: trellis-arrowhead
  - position: 5
    prefix: --subfeatureClasses
    valueFrom: '{"wholeCDS": null, "CDS":"primary_gene_set-cds", "UTR": "primary_gene_set-utr", "exon":"container-100pct"}'
  - position: 7
    prefix: --cssClass
    valueFrom: container-16px
  - position: 9
    prefix: --type
    valueFrom: mRNA
  - position: 11
    prefix: --trackLabel
    valueFrom: $(inputs.tree[0])_current_models 
  - position: 13
    prefix: --key
    valueFrom: $(inputs.tree[0])_annotation
  - position: 15
    prefix: --out
    valueFrom: data/
    
inputs:
  tree:
    type: string[]
  in_gff:
    type: File
  in_trackList_json:
    type: File

outputs: 
  out_trackList_json:
    type: File
    outputBinding: 
      glob: data/trackList.json
  out_tracks:
    type: Directory
    outputBinding: 
      glob: data/tracks/
