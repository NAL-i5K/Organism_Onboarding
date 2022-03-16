#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  tree: string[]
  scientific_name: string[]
  genome_fasta_name: string[]
  deepPATH_apollo2_data: string[]
  host_production: string[]
  login_apollo2_production: string[]
  

steps:
  #step1 run create organism on Apollo2 
  apollo2_create_Organism:
    run: files_4_Apollo2Server/CreateOrganism/createOrganism-production.cwl
    in:
      host: host_production
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      PATH: PATH
      tree: tree
      deepPATH_apollo2_data: deepPATH_apollo2_data
      login_apollo2: login_apollo2_production
    out:
      [out_createOrganism_log]
  #step2 cat creatOrganism.log
  cat_createOrganismLog:
    run: files_4_Apollo2Server/CreateOrganism/cat_createOrganismLog.cwl
    in:
      in_createOrganismLog: apollo2_create_Organism/out_createOrganism_log
    out: []
  
outputs: []
