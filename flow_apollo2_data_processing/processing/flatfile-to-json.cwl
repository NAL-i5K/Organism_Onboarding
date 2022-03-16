#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_gff),
                   (inputs.in_data)];
        return LIST;
      }

baseCommand: [add_NCBI_annotation_track.py]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    prefix: -path
    valueFrom: flatfile-to-json.pl
  - position: 2
    prefix: -gff
    valueFrom: $(inputs.in_gff.basename)
  - position: 3
    prefix: -out
    valueFrom: data/
  - position: 4
    prefix: -organism
    valueFrom: $(inputs.scientific_name[0])_$(inputs.scientific_name[1]) 
  - position: 5
    prefix: -trackLabel1
    valueFrom: $(inputs.tree[0])_current_models
  - position: 6
    prefix: -release
    valueFrom: $(inputs.gff_release_number)
  - position: 7
    prefix: -source
    valueFrom: $(inputs.url_genomic_gff[0])
    
inputs:
  tree:
    type: string[]
  scientific_name:
    type: string[]
  gff_release_number:
    type: int
  url_genomic_gff:
    type: string[]
  in_gff:
    type: File
#  in_trackList_json:
#    type: File
  in_data:
    type: Directory
outputs: 
  out_trackList_json:
    type: File
    outputBinding: 
      glob: data/trackList.json
  out_tracks:
    type: Directory
    outputBinding: 
      glob: data/tracks/
