#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
#requirements:

inputs:
  tree: string[]
  organization: string
  url_genomic_fasta: string[]
  accession: string
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
       [readme_file]
  #step3 write url
  writeURL:
    run: writeURL.cwl
    in:
      readme_file: writeFirstLine/readme_file
      url: url_genomic_fasta
    out:
      [readme_file]
  #step4 write Information
  writeInfo:
    run: writeInfo.cwl
    in:
      readme_file: writeURL/readme_file
      tree: tree
      accession: accession
      link_to_publication: link_to_publication
    out:
      [readme_file]  
  #step5 write last line
  writeLastLine:
    run: writeLastLine.cwl
    in: 
      readme_file: writeInfo/readme_file
    out:
      [readme_file]

outputs:
  readme_file:
    type: File
    outputSource: create_readme/readme_file 
