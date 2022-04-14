#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  url_md5checksums: string[]?
  url_genomic_fasta: string[]
  path_genomic_fasta: File?
  url_genomic_gff: string[]
  path_genomic_gff: File?
  url_protein_fasta: string[]
  path_protein_fasta: File?
  url_transcript_fasta: string[]
  path_transcript_fasta: File?
  url_cds_fasta: string[]
  path_cds_fasta: File?

steps:
  conditional-wget-md5:
    in:
      all_url: 
        source: [url_genomic_fasta, url_genomic_gff, url_protein_fasta, url_transcript_fasta, url_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out: [url_string]
    run:
      class: CommandLineTool
      baseCommand: echo
      stdout: output.txt
      arguments:
        - position: 1
          valueFrom: $(inputs.all_url)
      inputs:
        all_url:  
          type: string[]
      outputs:
        url_string:
          type: string       
          outputBinding:
            glob: output.txt
            loadContents: true
            outputEval: $(self[0].contents)
  wget_md5checksums:
    run: wget_single.cwl
    when: $(inputs.url_string != "NA NA NA NA NA\n" )
    in:
      url_string: conditional-wget-md5/url_string
      in_url: url_md5checksums
    out: [out_wget]
  wget_genomic_fasta:
    run: wget_single.cwl
    when: $(inputs.url_genomic_fasta != "NA" )
    in:
      url_genomic_fasta: url_genomic_fasta
      in_url: url_genomic_fasta
    out: [out_wget]
  wget_genomic_gff:
    run: wget_single.cwl
    when: $(inputs.url_genomic_gff != "NA" )
    in:
      url_genomic_gff: url_genomic_gff
      in_url: url_genomic_gff
    out: [out_wget]
  wget_protein_fasta:
    run: wget_single.cwl
    when: $(inputs.url_protein_fasta != "NA" )
    in:
      url_protein_fasta: url_protein_fasta
      in_url: url_protein_fasta
    out: [out_wget]
  wget_transcript_fasta:
    run: wget_single.cwl
    when: $(inputs.url_transcript_fasta != "NA" )
    in:
      url_transcript_fasta: url_transcript_fasta
      in_url: url_transcript_fasta
    out: [out_wget]
  wget_cds_fasta:
    run: wget_single.cwl
    when: $(inputs.url_cds_fasta != "NA" )
    in:
      url_cds_fasta: url_cds_fasta
      in_url: url_cds_fasta
    out: [out_wget]
outputs:  
  OUT_md5checksums:
    type: File
    outputSource: wget_md5checksums/out_wget
  OUT_genomic_fasta:
    type: File
    outputSource: wget_genomic_fasta/out_wget
  OUT_genomic_gff:
    type: File
    outputSource: wget_genomic_gff/out_wget
  OUT_protein_fasta:
    type: File
    outputSource: wget_protein_fasta/out_wget
  OUT_transcript_fasta:
    type: File
    outputSource: wget_transcript_fasta/out_wget
  OUT_cds_fasta:
    type: File
    outputSource: wget_cds_fasta/out_wget
  url_string:
    type: string
    outputSource: conditional-wget-md5/url_string
