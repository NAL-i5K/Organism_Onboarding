#!/usr/bin/env cwl-runner
cwlVersion: v1.2
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
  url_md5checksums: string[]?
  deepPATH_genomic_fasta: string[]
  url_genomic_fasta: string[]
  path_genomic_fasta: File?
  deepPATH_analyses: string[]
  url_genomic_gff: string[]
  path_genomic_gff: File?
  gff_release_number: int
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[]
  path_protein_fasta: File?
  path_transcript_fasta: File?
  path_cds_fasta: File?
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  organization: string
  link_to_publication: string
  url_table_file: string[]
  path_GO: File?
  path_KEGG: File?

steps:
  #step1 
  download:
    run: flow_download/workflow.cwl
    in:
      url_md5checksums: url_md5checksums
      url_genomic_fasta: url_genomic_fasta
      path_genomic_fasta: path_genomic_fasta
      url_genomic_gff: url_genomic_gff
      path_genomic_gff: path_genomic_gff
      url_protein_fasta: url_protein_fasta
      path_protein_fasta: path_protein_fasta
      url_transcript_fasta: url_transcript_fasta
      path_transcript_fasta: path_transcript_fasta
      url_cds_fasta: url_cds_fasta
      path_cds_fasta: path_cds_fasta
      url_table_file: url_table_file
    out:
      [OUT_md5checksums,   #'*.txt'
       OUT_genomic_fasta,  #'*.gz'
       OUT_genomic_gff,    #'*.gz'
       OUT_protein_fasta,            #'*.gz'
       OUT_transcript_fasta,         #'*.gz'
       OUT_cds_fasta,                #'*.gz'
       OUT_table,                    #'*.gz'
       url_string
       ]                
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
      in_table: download/OUT_table
      path_genomic_fasta: path_genomic_fasta
      path_genomic_gff: path_genomic_gff
      path_protein_fasta: path_protein_fasta
      path_transcript_fasta: path_transcript_fasta
      path_cds_fasta: path_cds_fasta
      url_string: download/url_string
      url_genomic_fasta: url_genomic_fasta
      url_genomic_gff: url_genomic_gff
      url_protein_fasta: url_protein_fasta
      url_transcript_fasta: url_transcript_fasta
      url_cds_fasta: url_cds_fasta
      url_table_file: url_table_file
    out:
      [OUT_extract,  #'*.txt2', extracted from *.txt
       OUT_check,    #'*.log', log file for execution of md5sum -c
       OUT_genomic_fasta, #'*.fa, '*.fna', '*.faa'
       OUT_genomic_gff,   #'*.gff', '*.gff3'
       OUT_protein_fasta,
       OUT_transcript_fasta, 
       OUT_cds_fasta,
       OUT_table
      ]
  #step3
  add_annotation:
    run: add-annotation/add_annotation.cwl
    when: $(inputs.url_table_file != "NA")
    in:
      url_table_file: url_table_file
      in_GO: path_GO
      in_KEGG: path_KEGG
      in_gff: 
        source: [md5checksums/OUT_genomic_gff, path_genomic_gff]
        pickValue: first_non_null
      in_table: md5checksums/OUT_table
    out:
      [processed_gff]
  #step4
  gaps_or_not:
    run: gaps_or_not.cwl
    in:
      fasta_file:
        source: [md5checksums/OUT_genomic_fasta, path_genomic_fasta]
        pickValue: first_non_null
    out:
      [gap_lines]
  #verify:
  #fasta_diff,gff3_QC......
  #step5
  apollo2_data_processing:
    run: flow_apollo2_data_processing/processing/workflow.cwl
    in:
      gap_lines: gaps_or_not/gap_lines
      tree: tree
      scientific_name: scientific_name
      gff_release_number: gff_release_number
      url_genomic_gff: url_genomic_gff
      in_fasta: 
        source: [md5checksums/OUT_genomic_fasta, path_genomic_fasta]
        pickValue: first_non_null
      in_gff: add_annotation/processed_gff
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
  #step6
  create_assembly_readme:
    run: flow_create_readme/readme-assembly-workflow.cwl
    in: 
      tree: tree
      scientific_name: scientific_name
      organization: organization
      url_genomic_fasta: url_genomic_fasta
      link_to_publication: link_to_publication
    out: [readme_file]
  #step7
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
      original_gff: 
        source: [md5checksums/OUT_genomic_gff, path_genomic_gff]
        pickValue: first_non_null
      processed_gff: add_annotation/processed_gff
    out: [readme_file] 
  #step8
  dispatch:
    run: flow_dispatch/workflow.cwl
    in:
      gap_lines: gaps_or_not/gap_lines
      url_string: download/url_string
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: 
        source: [md5checksums/OUT_genomic_fasta, path_genomic_fasta]
        pickValue: first_non_null
      deepPATH_analyses: deepPATH_analyses
      in_genomic_gff: add_annotation/processed_gff
      #
      in_protein_fasta: 
        source: [md5checksums/OUT_protein_fasta, path_protein_fasta]
        pickValue: first_non_null
      in_transcript_fasta: 
        source: [md5checksums/OUT_transcript_fasta, path_transcript_fasta]
        pickValue: first_non_null
      in_cds_fasta: 
        source: [md5checksums/OUT_cds_fasta, path_cds_fasta]
        pickValue: first_non_null
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
      in_gaps_bigwig: apollo2_data_processing/OUT_gaps_bigwig # this will be null if there are no gaps
      in_gc_bigwig: apollo2_data_processing/OUT_gc_bigwig
      in_trackList_json: apollo2_data_processing/OUT_trackList_json
      in_trackList_json_bak: apollo2_data_processing/OUT_trackList_json_bak
      original_gff: 
        source: [md5checksums/OUT_genomic_gff, path_genomic_gff]
        pickValue: first_non_null
    out:
      [out_dummy,
      processed_gff,
      original_gff
      ]

outputs:  []
