#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    #gaps file
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gaps.bigwig.gz
    #target directory
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/5.Other files/Gaps in Assembly/.

inputs:
  in_dummy: 
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]
  scientific_name:
    type: string[]
  genome_fasta_name:
    type: string[]
  deepPATH_bigwig:
    type: string[]
  MAIN_PATH:
    type: string

outputs: []
