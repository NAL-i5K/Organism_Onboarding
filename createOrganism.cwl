#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement

baseCommand: [createOrganism.py]

$namespaces:
  cwltool: "http://commonwl.org/cwltool#"

hints:
  cwltool:LoadListingRequirement:
    loadListing: shallow_listing

arguments: 
  - position: 1
    prefix: -host
    valueFrom: $(inputs.host)
  - position: 3
    prefix: -organism
    valueFrom: $(inputs.scientific_name[0]) $(inputs.scientific_name[1])
  - position: 5
    prefix: -genus
    valueFrom: $(inputs.scientific_name[0])
  - position: 7
    prefix: -species
    valueFrom: $(inputs.scientific_name[1])
  - position: 9
    prefix: -directory
    valueFrom: $(inputs.PATH[0])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  - position: 11
    prefix: -blatdb
    valueFrom: $(inputs.PATH[2])/$(inputs.in_tree[0])/$(inputs.in_2bi.basename)
  - position: 13
    prefix: -username
    valueFrom: $(inputs.login_apollo2[0])
  - position: 15
    prefix: -password
    valueFrom: $(inputs.login_apollo2[1])
  - position: 17
    valueFrom: -publicMode

inputs:
  host:
    type: string
  scientific_name:
    type: string[]    
  PATH:
    type: string[]
  in_tree:
    type: string[]
  in_2bi:
    type: File  
  login_apollo2:
    type: string[]

outputs:
  out_createOrganism_log:
    type: stdout
stdout: $(inputs.PATH[1])/$(inputs.in_tree[0])/$(inputs.in_tree[1])/createOrganism.log

