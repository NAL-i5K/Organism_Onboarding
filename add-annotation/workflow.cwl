#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  in_gff: File
  url_table_file: string[]
  in_GO: File
  in_KEGG: File
  in_md5checksums: File?
  url_string: string
  url_md5checksums: string[]?

steps:
  #step1
  wget_table:
    run: ../flow_download/wget_single.cwl
    in:
      in_url: url_table_file
    out:
      [out_wget]
  #step2
  wget_md5checksums:
    run: ../flow_download/wget_single.cwl
    when: $(inputs.url_string == "NA NA NA NA NA\n" )
    in:
      url_string: url_string
      in_url: url_md5checksums
    out: [out_wget]
  #step3
  extract_md5checksums:
    run: ../flow_md5checksums/extract_md5checksums.cwl
    in:
      in_txt:
        source: [in_md5checksums, wget_md5checksums/out_wget]
        pickValue: first_non_null
      in_gz:
        source: [wget_table/out_wget]
        pickValue: all_non_null
        linkMerge: merge_flattened    
    out:
     [out_extract] #*.txt2 is the extracted version of md5checksums.txt
  #step4
  check_md5checksums:
    run: ../flow_md5checksums/check_md5checksums.cwl
    in:
      in_check: extract_md5checksums/out_extract
      in_gz:
        source: [wget_table/out_wget]
        pickValue: all_non_null
        linkMerge: merge_flattened    
    out:
      [out_check]
  #step5
  unzip_table:
    run: ../flow_md5checksums/gunzip_single.cwl
    in:
      in_dummy: check_md5checksums/out_check  #dummy data to insure the order of execution
      in_gz: wget_table/out_wget
    out:
      [out_gz]
  #step6
  add_annotation:
    run: add_annotation.cwl
    in:
      in_GO: in_GO
      in_KEGG: in_KEGG
      in_gff: in_gff
      in_table: unzip_table/out_gz
    out:
      [processed_gff]  
  
outputs: 
  processed_gff:
    type: File
    outputSource: add_annotation/processed_gff
