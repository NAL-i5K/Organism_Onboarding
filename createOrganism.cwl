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

baseCommand: [createOrganism.py]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    prefix: -host
    valueFrom: $(inputs.in_host)
  - position: 3
    prefix: -organism
    valueFrom: $(inputs.in_tree[3]) $(inputs.in_tree[4])
  - position: 5
    prefix: -genus
    valueFrom: $(inputs.in_tree[3])
  - position: 7
    prefix: -species
    valueFrom: $(inputs.in_tree[4])
  - position: 9
    prefix: -directory
    valueFrom: /app/data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 11
    prefix: -blatdb
    valueFrom: /usr/local/blat/db/$(inputs.in_tree[0])/$(inputs.in_2bi.basename)
  - position: 13
    prefix: -username
    valueFrom: $(inputs.in_login_apollo2[0])
  - position: 15
    prefix: -password
    valueFrom: $(inputs.in_login_apollo2[1])
  - position: 17
    valueFrom: -publicMode

inputs:
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_2bi:
    type: File
  in_host:
    type: string
  in_login_apollo2:
    type: string[]

outputs:
  out_createOrganism_log:
    type: stdout
stdout: $(inputs.in_dir.basename)/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/createOrganism.log

