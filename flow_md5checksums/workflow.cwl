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
  in_protein_fasta: File[]?
  in_transcript_fasta: File?
  in_cds_fasta: File?
  path_genomic_fasta: File?
  path_genomic_gff: File?
  path_protein_fasta: File[]?
  path_transcript_fasta: File?
  path_cds_fasta: File?
  
steps:
  conditional-md5:
    in:
      in_gz: 
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out: [in_gz, content_string]
    run:
      class: CommandLineTool
      baseCommand: echo
      stdout: in_gz_content.txt
      arguments:
        - position: 1
          valueFrom: $(inputs.in_gz)
      inputs:
        in_gz:  
          type: File[]?
      outputs:
        in_gz:  
          type: File[]?
        content_string:
          type: string       
          outputBinding:
            glob: in_gz_content.txt
            loadContents: true
            outputEval: $(self[0].contents)
  extract_md5checksums:
    run: extract_md5checksums.cwl
    when: $(inputs.content_string != "\n" )
    in:
      content_string: conditional-md5/content_string
      in_txt: in_md5checksums
      in_gz: 
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out:
     [out_extract] #*.txt2 is the extracted version of md5checksums.txt
  check_md5checksums:
    run: check_md5checksums.cwl
    when: $(inputs.content_string != "\n" )
    in:
      content_string: conditional-md5/content_string
      in_check: extract_md5checksums/out_extract
      in_gz:
        source: [in_genomic_fasta, in_genomic_gff, in_protein_fasta, in_transcript_fasta, in_cds_fasta]
        pickValue: all_non_null
        linkMerge: merge_flattened
    out:
      [out_check]
  gunzip_genomic_fasta:
    run: gunzip_single.cwl
    when: $(inputs.path_genomic_fasta.basename == "README.md" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      path_genomic_fasta: path_genomic_fasta
      in_gz: in_genomic_fasta
    out:
      [out_gz]
  gunzip_genomic_gff:
    run: gunzip_single.cwl
    when: $(inputs.path_genomic_gff.basename == "README.md" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      path_genomic_gff: path_genomic_gff
      in_gz: in_genomic_gff
    out:
      [out_gz]
  gunzip_protein_fasta:
    run: gunzip_multi.cwl
    when: $(inputs.path_protein_fasta.basename == "README.md" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      path_protein_fasta: path_protein_fasta
      in_gz: in_protein_fasta
    out:
      [out_gz]
  gunzip_transcript_fasta:
    run: gunzip_single.cwl
    when: $(inputs.path_transcript_fasta.basename == "README.md" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      path_transcript_fasta: path_transcript_fasta
      in_gz: in_transcript_fasta
    out:
      [out_gz]
  gunzip_cds_fasta:
    run: gunzip_single.cwl
    when: $(inputs.path_cds_fasta.basename == "README.md" )
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      path_cds_fasta: path_cds_fasta
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
