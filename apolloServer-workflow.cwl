#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  tree: string[]
  scientific_name: string[]
  deepPATH_apollo2_data: string[]
  host_production: string[]
  login_apollo2_production: string[]
  Apollo_account: string
  

steps:
  #step 1
  createFolder:
    run: flow_transferFiles2Apollo/createFolder.cwl
    in:
      Apollo_account: Apollo_account
      tree: tree
    out: [out_dummy]
  #step 2
  dataTransfer-jbrowse:
    run: flow_transferFiles2Apollo/dataTransfer-jbrowse.cwl
    in:
      Apollo_account: Apollo_account
      tree: tree
      in_dummy: createFolder/out_dummy
    out: [out_dummy]
  #step 3
  dataTransfer-blat:
    run: flow_transferFiles2Apollo/dataTransfer-blat.cwl
    in:
      Apollo_account: Apollo_account
      tree: tree
      in_dummy: dataTransfer-jbrowse/out_dummy
    out: [out_dummy]
  #step 4
  apollo2_create_Organism:
    run: flow_transferFiles2Apollo/createOrganism-TF.cwl
    in:
      in_dummy: dataTransfer-blat/out_dummy
      host: host_production
      scientific_name: scientific_name
      PATH: PATH
      tree: tree
      deepPATH_apollo2_data: deepPATH_apollo2_data
      login_apollo2: login_apollo2_production
    out:
      [out_createOrganism_log]
outputs: []
