#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    #fasta file
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.genome_fasta_name[0]).gz
    #readme file
    #target directory
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/1.Genome Assembly/$(inputs.tree[1])/Scaffolds/.

inputs:
  in_dummy: 
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]
  genome_fasta_name:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  MAIN_PATH:
    type: string
  LINK_DIR:
    type: string

outputs: []
