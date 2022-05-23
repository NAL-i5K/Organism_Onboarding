#! /usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  tree: string[]
  organization: string
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_cds_fasta: string[]
  url_transcript_fasta: string[]
  link_to_publication: string
  original_gff: File
  processed_gff: File?
  url_table_file: string[]

steps:
  #step1 create_yml_File
  create_readme:
    run: create_readme.cwl
    in: []
    out:
      [readme_file]
  #step2 write_First_Line
  writeFirstLine:
    run: writeFirstLine.cwl
    in:
      readme_file: create_readme/readme_file
      organization: organization
    out:
       [out_readme_file]
  #step3 write url - gff
  writeURL-gff:
    run: writeURL.cwl
    in:
      readme_file: writeFirstLine/out_readme_file
      url: url_genomic_gff
    out:
      [out_readme_file]
  #step4 write url - cds
  writeURL-cds:
    run: writeURL.cwl
    in:
      readme_file: writeURL-gff/out_readme_file
      url: url_cds_fasta
    out:
      [out_readme_file]
  #step5 write url - transcript
  writeURL-transcript:
    run: writeURL.cwl
    in:
      readme_file: writeURL-cds/out_readme_file
      url: url_transcript_fasta
    out:
      [out_readme_file]
  #step3 write url - protein
  writeURL-protein:
    run: writeURL.cwl
    in:
      readme_file: writeURL-transcript/out_readme_file
      url: url_protein_fasta
    out:
      [out_readme_file]
  #step4 write Information
  writeInfo:
    run: writeInfo-genePred.cwl
    in:
      readme_file: writeURL-protein/out_readme_file
      tree: tree
      link_to_publication: link_to_publication
    out:
      [out_readme_file]  
  #step5 write last line
  writeLastLine_v1:
    run: writeLastLine-genePred.cwl
    when: $(inputs.url_table_file == "NA")
    in: 
      url_table_file: url_table_file
      readme_file: writeInfo/out_readme_file
    out:
      [out_readme_file]
  writeLastLine_v2:
    run: writeLastLine-genePred_annotation.cwl
    when: $(inputs.url_table_file != "NA")
    in: 
      url_table_file: url_table_file
      readme_file: writeInfo/out_readme_file
      original_gff: original_gff
      processed_gff: processed_gff
    out:
      [out_readme_file]

outputs:
  readme_file:
    type: File
    outputSource: create_readme/readme_file 
