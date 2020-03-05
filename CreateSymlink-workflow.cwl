#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: ScatterFeatureRequirement

inputs:
  PATH: string[]
  tree: string[]
  genome_fasta_name: string[]
  protein_fasta_name: string[]
  transcript_fasta_name: string[]
  cds_fasta_name: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  deepPATH_bigwig: string[]
  MAIN_PATH: string
  LINK_DIR: string
  ASSEMBLY_NAME: string

steps:
  #step1 setup folder
  setup_folder:
    run: flow_reorganize_symlinks/setup_folder.cwl
    in:
      MAIN_PATH: MAIN_PATH
      LINK_DIR: LINK_DIR
      ASSEMBLY_NAME: ASSEMBLY_NAME
    out: [out_dummy]
  #step2 gzip - scaffold file
  scaffold_gzip:
    run: flow_reorganize_symlinks/scaffold_gzip.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
    out: [out_dummy] 
  #step3 symlink - scaffold file
  scaffold_symlink:
    run: flow_reorganize_symlinks/scaffold_symlink.cwl
    in:
      in_dummy: scaffold_gzip/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      MAIN_PATH: MAIN_PATH
      LINK_DIR: LINK_DIR
    out: []
  #step4 symlink - analyses_protein files
  analyses_symlink_protein:
    run: flow_reorganize_symlinks/analyses_symlink_protein.cwl
    scatter: protein_fasta_name
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      protein_fasta_name: protein_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      MAIN_PATH: MAIN_PATH
      LINK_DIR: LINK_DIR
    out: []
  #step5 symlink - analyses files
  analyses_symlink:
    run: flow_reorganize_symlinks/analyses_symlink.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      transcript_fasta_name: transcript_fasta_name
      cds_fasta_name: cds_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      MAIN_PATH: MAIN_PATH
      LINK_DIR: LINK_DIR
    out: []
  #step6 gzip - bigwig files
  bigwig_gzip:
    run: flow_reorganize_symlinks/bigwig_gzip.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_bigwig: deepPATH_bigwig
    out: [out_dummy]
  #step7 symlink - bigwig files
  bigwig_symlink:
    run: flow_reorganize_symlinks/bigwig_symlink.cwl 
    in:
      in_dummy: bigwig_gzip/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_bigwig: deepPATH_bigwig
      MAIN_PATH: MAIN_PATH
      LINK_DIR: LINK_DIR
    out: []

outputs: []
  
