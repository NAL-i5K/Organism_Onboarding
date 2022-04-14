#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_md5checksums: File?
  in_genomic_fasta: File?
  in_genomic_gff: File?
  in_protein_fasta: File?
  in_transcript_fasta: File?
  in_cds_fasta: File?
  path_genomic_fasta: File?
  path_genomic_gff: File?
  path_protein_fasta: File?
  path_transcript_fasta: File?
  path_cds_fasta: File?
  url_string: string
  url_genomic_fasta: string[]
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_transcript_fasta: string[]
  url_cds_fasta: string[]
  
steps:
  extract_md5checksums:
    run: extract_md5checksums.cwl
    when: $(inputs.url_string != "NA NA NA NA NA\n" )
    in:
      url_string: url_string
      in_txt: in_md5checksums
      in_gz: 
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out:
     [out_extract] #*.txt2 is the extracted version of md5checksums.txt
  check_md5checksums:
    run: check_md5checksums.cwl
    when: $(inputs.url_string != "NA NA NA NA NA\n" )
    in:
      url_string: url_string
      in_check: extract_md5checksums/out_extract
      in_gz:
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out:
      [out_check]
  gunzip_genomic_fasta:
    run: gunzip_single.cwl
    when: $(inputs.url_genomic_fasta != "NA" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      url_genomic_fasta: url_genomic_fasta
      in_gz: in_genomic_fasta
    out:
      [out_gz]
  gunzip_genomic_gff:
    run: gunzip_single.cwl
    when: $(inputs.url_genomic_gff != "NA" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      url_genomic_gff: url_genomic_gff
      in_gz: in_genomic_gff
    out:
      [out_gz]
  gunzip_protein_fasta:
    run: gunzip_single.cwl
    when: $(inputs.url_protein_fasta != "NA" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      url_protein_fasta: url_protein_fasta
      in_gz: in_protein_fasta
    out:
      [out_gz]
  gunzip_transcript_fasta:
    run: gunzip_single.cwl
    when: $(inputs.url_transcript_fasta != "NA" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      url_transcript_fasta: url_transcript_fasta
      in_gz: in_transcript_fasta
    out:
      [out_gz]
  gunzip_cds_fasta:
    run: gunzip_single.cwl
    when: $(inputs.url_cds_fasta != "NA" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      url_cds_fasta: url_cds_fasta
      in_gz: in_cds_fasta
    out:
      [out_gz]
outputs:
  OUT_extract:
    type: File
    outputSource: extract_md5checksums/out_extract
  OUT_check:
    type: File
    outputSource: check_md5checksums/out_check
  OUT_genomic_fasta:
    type: File
    outputSource: gunzip_genomic_fasta/out_gz
  OUT_genomic_gff:
    type: File
    outputSource: gunzip_genomic_gff/out_gz
  OUT_protein_fasta:
    type: File
    outputSource: gunzip_protein_fasta/out_gz
  OUT_transcript_fasta:
    type: File
    outputSource: gunzip_transcript_fasta/out_gz
  OUT_cds_fasta:
    type: File
    outputSource: gunzip_cds_fasta/out_gz
