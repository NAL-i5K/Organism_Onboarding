#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_md5checksums: File
  in_genomic_fasta: File
  in_genomic_gff: File
  in_protein_fasta: File[]
  in_transcript_fasta: File
  in_cds_fasta: File
  
steps:
  extract_md5checksums:
    run: extract_md5checksums.cwl
    in:
      in_txt: in_md5checksums
      in_gz: 
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        linkMerge: merge_flattened
    out:
     [out_extract] #*.txt2 is the extracted version of md5checksums.txt
  check_md5checksums:
    run: check_md5checksums.cwl
    in:
      in_check: extract_md5checksums/out_extract
      in_gz:
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        linkMerge: merge_flattened
    out:
      [out_check]
  gunzip_genomic_fasta:
    run: gunzip_single.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      in_gz: in_genomic_fasta
    out:
      [out_gz]
  gunzip_genomic_gff:
    run: gunzip_single.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      in_gz: in_genomic_gff
    out:
      [out_gz]
  gunzip_protein_fasta:
    run: gunzip_multi.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      in_gz: in_protein_fasta
    out:
      [out_gz]
  gunzip_transcript_fasta:
    run: gunzip_single.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      in_gz: in_transcript_fasta
    out:
      [out_gz]
  gunzip_cds_fasta:
    run: gunzip_single.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
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
    type: File[]
    outputSource: gunzip_protein_fasta/out_gz
  OUT_transcript_fasta:
    type: File
    outputSource: gunzip_transcript_fasta/out_gz
  OUT_cds_fasta:
    type: File
    outputSource: gunzip_cds_fasta/out_gz
