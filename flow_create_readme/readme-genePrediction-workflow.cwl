#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: ScatterFeatureRequirement

inputs:
  tree: string[]
  organization: string
  url_genomic_gff: string[]
  url_protein_fasta: string[]
  url_cds_fasta: string[]
  url_transcript_fasta: string[]
  link_to_publication: string

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
    run: writeURL-protein.cwl
    scatter: url
    in:
      readme_file: writeURL-transcript/out_readme_file
      url: url_protein_fasta
    out:
      [out_dummy]
  #step4 write Information
  writeInfo:
    run: writeInfo-genePred.cwl
    in:
      in_dummy: writeURL-protein/out_dummy
      readme_file: writeURL-transcript/out_readme_file
      tree: tree
      link_to_publication: link_to_publication
    out:
      [out_readme_file]  
  #step5 write last line
  writeLastLine:
    run: writeLastLine-genePred.cwl
    in: 
      readme_file: writeInfo/out_readme_file
    out:
      [out_readme_file]

outputs:
  readme_file:
    type: File
    outputSource: create_readme/readme_file 
