#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  managePy_Path: string
  blastdb_Path_stage: string[]
  hmmerdb_Path_stage: string[]
  tree: string[]
  scientific_name: string[]
  deepPATH_genomic_fasta: string[]
  path_genomic_fasta: File
  deepPATH_analyses: string[]
  path_genomic_gff: File
  gff_release_number: int
  path_protein_fasta: File
  path_transcript_fasta: File
  path_cds_fasta: File
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  host_stage: string[]
  login_apollo2_stage: string[]
  organization: string
  accession: string
  link_to_publication: string
  url_genomic_fasta: string[]
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[]

steps:
  #step1 
  apollo2_data_processing:
    run: flow_apollo2_data_processing/processing/workflow.cwl
    in:
      tree: tree
      scientific_name: scientific_name
      gff_release_number: gff_release_number
      url_genomic_gff: url_genomic_gff
      in_fasta: path_genomic_fasta
      in_gff: path_genomic_gff
    out:
      [OUT_2bi,
      OUT_seq,
      OUT_tracks_conf,
      OUT_tracks,
      OUT_names,
      OUT_gaps_bigwig,
      OUT_gc_bigwig,
      OUT_trackList_json,
      OUT_trackList_json_bak,
      ]
  #step2
  create_assembly_readme:
    run: flow_create_readme/readme-assembly-workflow.cwl
    in: 
      tree: tree
      scientific_name: scientific_name
      organization: organization
      url_genomic_fasta: url_genomic_fasta
      accession: accession
      link_to_publication: link_to_publication
    out: [readme_file]
  #step3
  create_genePrediction_readme:
    run: flow_create_readme/readme-genePrediction-workflow.cwl
    in:
      tree: tree
      organization: organization
      url_genomic_gff: url_genomic_gff
      url_protein_fasta: url_protein_fasta
      url_cds_fasta: url_cds_fasta
      url_transcript_fasta: url_transcript_fasta
      link_to_publication: link_to_publication
    out: [readme_file] 
  #step4     
  dispatch:
    run: flow_dispatch/workflow.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: path_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      in_genomic_gff: path_genomic_gff
      #
      in_protein_fasta: path_protein_fasta
      in_transcript_fasta: path_transcript_fasta
      in_cds_fasta: path_cds_fasta
      in_assembly_readme: create_assembly_readme/readme_file
      in_genePrediction_readme: create_genePrediction_readme/readme_file
      #
      deepPATH_apollo2_data: deepPATH_apollo2_data
      deepPATH_bigwig: deepPATH_bigwig
      in_2bi: apollo2_data_processing/OUT_2bi
      in_seq: apollo2_data_processing/OUT_seq
      in_tracks_conf: apollo2_data_processing/OUT_tracks_conf
      in_tracks: apollo2_data_processing/OUT_tracks
      in_names: apollo2_data_processing/OUT_names
      in_gaps_bigwig: apollo2_data_processing/OUT_gaps_bigwig
      in_gc_bigwig: apollo2_data_processing/OUT_gc_bigwig
      in_trackList_json: apollo2_data_processing/OUT_trackList_json
      in_trackList_json_bak: apollo2_data_processing/OUT_trackList_json_bak
    out:
      [out_dummy]
  #step7
  apollo2_create_organism:
    run: createOrganism.cwl
    in: 
      in_dummy: dispatch/out_dummy 
      host: host_stage
      scientific_name: scientific_name
      PATH: PATH
      tree: tree
      in_2bi: apollo2_data_processing/OUT_2bi
      deepPATH_apollo2_data: deepPATH_apollo2_data
      login_apollo2: login_apollo2_stage
    out:
      [out_createOrganism_log]
      
outputs:  []
