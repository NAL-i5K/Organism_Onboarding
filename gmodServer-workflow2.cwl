#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: InlineJavascriptRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  scientific_name: string[]
  PATH: string[]
  tree: string[]
  managePy_Path: string
  blastdb_Path_production: string[]
  hmmerdb_Path_production: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  Gmod_account: string
  genome_fasta_name: string[]
  transcript_fasta_name: string[]
  cds_fasta_name: string[]
  protein_fasta_name: string[]

steps:
  #Step1 create folder on production server
  createFolder:
    run: files_4_gmod/createFolder-on-prod.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      Gmod_account: Gmod_account
    out: [out_dummy]
  #Step2 transfer_fasta_files
  dataTransfer-fasta:
    run: files_4_gmod/dataTransfer-fasta.cwl
    in:
      Gmod_account: Gmod_account
      tree: tree
      PATH: PATH
      in_dummy: createFolder/out_dummy
    out: [out_dummy]
  #Step3 create yml file
  create_ymlFile:
    run: files_4_gmod/flow_create_yml/workflow.cwl
    in:
      scientific_name: scientific_name
      PATH: PATH
      tree: tree
      managePy_Path: managePy_Path
      blastdb_Path_production: blastdb_Path_production
      hmmerdb_Path_production: hmmerdb_Path_production
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      genome_fasta_name: genome_fasta_name
      transcript_fasta_name: transcript_fasta_name
      cds_fasta_name: cds_fasta_name
      protein_fasta_name: protein_fasta_name
    out:
      [Yml_file]
  #step4 transfer_yml_file
  dataTransfer-yml:
    run: files_4_gmod/dataTransfer-yml.cwl
    in:
      Gmod_account: Gmod_account
      tree: tree
      PATH: PATH
      yml_file: create_ymlFile/Yml_file      
    out: []

outputs: []
   
 

