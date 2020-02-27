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
  genome_fasta_name: string[]
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  host_production: string[]
  login_apollo2_production: string[]
  Apollo_account: string
  Gmod_account: string
  

steps:
  #step1 create folders on apollo production server  
  createFolder:
    run: files_4_Apollo2Server/createFolder.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
    out: [out_dummy]
  #step2 transfer folder bigwig to apollo production server 
  dataTransfer-bigwig:
    run: files_4_Apollo2Server/dataTransfer-bigwig.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
      in_dummy: createFolder/out_dummy
    out: [out_dummy]
  #step3 transfer folder jbrowse to apollo production server
  dataTransfer-jbrowse:
    run: files_4_Apollo2Server/dataTransfer-jbrowse.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-bigwig/out_dummy
    out: [out_dummy]
  #step4 transfer folder blat to apollo production server
  dataTransfer-blat:
    run: files_4_Apollo2Server/dataTransfer-blat.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-jbrowse/out_dummy
    out: [out_dummy]
  #step4 run create organism on Apollo2 
  apollo2_create_Organism:
    run: files_4_Apollo2Server/createOrganism-production.cwl
    in:
      in_dummy: dataTransfer-blat/out_dummy
      host: host_production
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      PATH: PATH
      tree: tree
      deepPATH_apollo2_data: deepPATH_apollo2_data
      login_apollo2: login_apollo2_production
    out:
      [out_createOrganism_log]
  #step5 cat creatOrganism.log
  cat_createOrganismLog:
    run: files_4_Apollo2Server/cat_createOrganismLog.cwl
    in:
      in_createOrganismLog: apollo2_create_Organism/out_createOrganism_log
    out: []
  #step5 create folders on gmod production server
  createFolder-2gmodProd:
    run: files_4_Apollo2Server/createFolder-2gmodProd.cwl
    in: 
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
    out:
      [out_dummy]
  #step6 transfer fasta files to gmod production server
  dataTransfer-fasta-2gmodProd:
    run: files_4_Apollo2Server/dataTransfer-fasta-2gmodProd.cwl
    in:
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      in_dummy: createFolder-2gmodProd/out_dummy
    out: []
  #step7 transfer genomic fasta file to gmod production server
  dataTransfer-gff-2gmodProd:
    run: files_4_Apollo2Server/dataTransfer-gff-2gmodProd.cwl
    in:
      Gmod_account: Gmod_account
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      genome_fasta_name: genome_fasta_name
      in_dummy: createFolder-2gmodProd/out_dummy
    out: []

outputs: []
