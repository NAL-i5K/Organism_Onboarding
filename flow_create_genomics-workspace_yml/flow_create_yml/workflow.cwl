#! /usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
#requirements:

inputs:
  scientific_name: string[]
  PATH: string[]
  tree: string[]
  managePy_Path: string
  blastdb_Path_production: string[]
  hmmerdb_Path_production: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  genome_fasta_name: string[]
  transcript_fasta_name: string[]
  cds_fasta_name: string[]
  protein_fasta_name: string[]

steps:
  #step1 create_yml_File
  create_yml:
    run: create_yml.cwl
    in: []
    out:
      [Yml_file]
  #step2 write_First_Line
  writeFirstLine:
    run: writeFirstLine.cwl
    in:
      yml_file: create_yml/Yml_file
    out:
       [Yml_file]
  #step3 edit yml file
  writeYml:
    run: writeYml.cwl
    in:
      yml_file: writeFirstLine/Yml_file
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
    out:
      [Yml_file]
  #step4 edit yml file - protein fasta files
  writeYml-protein-fasta:
    run: writeYml-protein-fasta.cwl
    in:
      yml_file: writeYml/Yml_file
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      protein_fasta_name: protein_fasta_name
    out:
      [Yml_file]  

outputs:
  Yml_file:
    type: File
    outputSource: create_yml/Yml_file 
