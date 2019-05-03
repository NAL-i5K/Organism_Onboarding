#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dir: Directory
  in_tree: string[]  

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

steps:
  #To /app/data/other_species/
  data:
    run: data.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out: []
  #To /usr/local/blat/db/
  blatdb:
    run: blatdb.cwl
    in:
      in_dir: in_dir
      in_tree: in_tree
    out: []

outputs: []
