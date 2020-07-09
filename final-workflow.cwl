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
  url_md5checksums: string[]
  deepPATH_genomic_fasta: string[]
  url_genomic_fasta: string[]
  deepPATH_analyses: string[]
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[]
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  host_stage: string[]
  login_apollo2_stage: string[]
  organization: string
  accession: string
  link_to_publication: string

steps:
  #step1 
  download:
    run: flow_download/workflow.cwl
    in:
      url_md5checksums: url_md5checksums
      url_genomic_fasta: url_genomic_fasta
      url_genomic_gff: url_genomic_gff
      url_protein_fasta: url_protein_fasta
      url_transcript_fasta: url_transcript_fasta
      url_cds_fasta: url_cds_fasta
    out:
      [OUT_md5checksums,   #'*.txt'
       OUT_genomic_fasta,  #'*.gz'
       OUT_genomic_gff,    #'*.gz'
       OUT_protein_fasta,            #'*.gz'
       OUT_transcript_fasta,         #'*.gz'
       OUT_cds_fasta]                #'*.gz'
  #step2  
  md5checksums:
    run: flow_md5checksums/workflow.cwl
    in:
      in_md5checksums: download/OUT_md5checksums
      in_genomic_fasta: download/OUT_genomic_fasta
      in_genomic_gff: download/OUT_genomic_gff
      in_protein_fasta: download/OUT_protein_fasta
      in_transcript_fasta: download/OUT_transcript_fasta
      in_cds_fasta: download/OUT_cds_fasta
    out:
      [
       OUT_extract,  #'*.txt2', extracted from *.txt
       OUT_check,    #'*.log', log file for execution of md5sum -c
       OUT_genomic_fasta, #'*.fa, '*.fna', '*.faa'
       OUT_genomic_gff,   #'*.gff', '*.gff3'
       OUT_protein_fasta,
       OUT_transcript_fasta, 
       OUT_cds_fasta
      ]

  #verify:
  #fasta_diff,gff3_QC......
  #step3
  apollo2_data_processing:
    run: flow_apollo2_data_processing/processing/workflow.cwl
    in:
      tree: tree
      in_fasta: md5checksums/OUT_genomic_fasta
      in_gff: md5checksums/OUT_genomic_gff
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
  #step4
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
  #step5
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
  #step6     
  dispatch:
    run: flow_dispatch/workflow.cwl
    in:
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: md5checksums/OUT_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      in_genomic_gff: md5checksums/OUT_genomic_gff
      #
      in_protein_fasta: md5checksums/OUT_protein_fasta
      in_transcript_fasta: md5checksums/OUT_transcript_fasta
      in_cds_fasta: md5checksums/OUT_cds_fasta
      in_assembly_readme: create_assembly_readme/readme_file
      in_genePrediction_readme: create_genePrediction_readme/readme_file
      in_md5checksums: download/OUT_md5checksums
      in_extract: md5checksums/OUT_extract
      in_check: md5checksums/OUT_check
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
      
 # #step8 genomics-workspace
 #  genomics-workspace:
 #    run: flow_genomicsWorkspace/genomics-workspace.cwl 
 #    in:
 #      scientific_name: scientific_name
 #      managePy_Path: managePy_Path
 #      blastdb_Path: blastdb_Path_stage
 #      hmmerdb_Path: hmmerdb_Path_stage
 #      tree: tree
 #      in_fasta: md5checksums/OUT_genomic_fasta
 #      in_fasta_protein: md5checksums/OUT_protein_fasta
 #      in_fasta_transcript: md5checksums/OUT_transcript_fasta
 #      in_fasta_cds: md5checksums/OUT_cds_fasta  
 #    out: []

outputs:  []
