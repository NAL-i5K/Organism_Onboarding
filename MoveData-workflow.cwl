#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: SubworkflowFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  tree: string[]
  scientific_name: string[]
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  host_production: string[]
  login_apollo2_production: string[]
  Apollo_account: string
  Gmod_account: string
  Gmod_stage_account: string
  genome_fasta_name: string[]
  transcript_fasta_name: string[]
  cds_fasta_name: string[]
  protein_fasta_name: string[]
  managePy_Path: string
  blastdb_Path_production: string[]
  hmmerdb_Path_production: string[]
  

steps:
  #step1 create folders on apollo production server  
  createFolder:
    run: files_4_Apollo2Server/MoveData/createFolder.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
    out: [out_dummy]
  #step2 transfer folder bigwig to apollo production server and change permission to 755
  dataTransfer-bigwig:
    run: files_4_Apollo2Server/MoveData/dataTransfer-bigwig.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
      in_dummy: createFolder/out_dummy
    out: [out_dummy]
  chmod-bigwig:
    run: files_4_Apollo2Server/MoveData/chmod-bigwig.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
      in_dummy: dataTransfer-bigwig/out_dummy
    out: []
  #step3 transfer folder jbrowse to apollo production server and change permission to 755
  dataTransfer-jbrowse:
    run: files_4_Apollo2Server/MoveData/dataTransfer-jbrowse.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-bigwig/out_dummy
    out: [out_dummy]
  chmod-jbrowse:
    run: files_4_Apollo2Server/MoveData/chmod-jbrowse.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-jbrowse/out_dummy
    out: []
  #step4 transfer folder blat to apollo production server and change permission to 755
  dataTransfer-blat:
    run: files_4_Apollo2Server/MoveData/dataTransfer-blat.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-jbrowse/out_dummy
    out: [out_dummy] 
  chmod-blat:
    run: files_4_Apollo2Server/MoveData/chmod-blat.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-blat/out_dummy
    out: []
  #step5 create folders on gmod production server
  createFolder-2gmodProd:
    run: files_4_Apollo2Server/MoveData/createFolder-2gmod.cwl
    in: 
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
    out: [out_dummy]
  #step6 transfer scaffold to gmod production server and change permission to 755
  dataTransfer-scaffold-2gmodProd:
    run: files_4_Apollo2Server/MoveData/dataTransfer-scaffold-2gmod.cwl
    in:
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_dummy: createFolder-2gmodProd/out_dummy
    out: [out_dummy]
  chmod-scaffold-2gmodProd:
    run: files_4_Apollo2Server/MoveData/chmod-scaffold-2gmod.cwl
    in:
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_dummy: dataTransfer-scaffold-2gmodProd/out_dummy
    out: []
  #step7 create folders on gmod stage server
  createFolder-2gmodStage:
    run: files_4_Apollo2Server/MoveData/createFolder-2gmod.cwl
    in:
      Gmod_account: Gmod_stage_account
      PATH: PATH
      tree: tree
    out: [out_dummy]
  #step8 transfer scaffold to gmod stage server and change permission to 755
  dataTransfer-scaffold-2gmodStage:
    run: files_4_Apollo2Server/MoveData/dataTransfer-scaffold-2gmod.cwl
    in:
      Gmod_account: Gmod_stage_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_dummy: createFolder-2gmodStage/out_dummy
    out: [out_dummy]
  chmod-scaffold-2gmodStage:
    run: files_4_Apollo2Server/MoveData/chmod-scaffold-2gmod.cwl
    in:
      Gmod_account: Gmod_stage_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_dummy: dataTransfer-scaffold-2gmodStage/out_dummy
    out: []
  #Step9 create yml file
  create_ymlFile:
    run: flow_create_genomics-workspace_yml/flow_create_yml/workflow.cwl
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
    out: [Yml_file]

outputs: 
  Yml_file:
    type: File
    outputSource: create_ymlFile/Yml_file
