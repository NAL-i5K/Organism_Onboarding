#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    #transcript fasta file
    position: 1
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/
    #target directory
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/Current\ Genome\ Assembly/.

inputs:
  in_dummy: 
    type: File
  tree:
    type: string[]
  scientific_name: 
    type: string[]
  MAIN_PATH:
    type: string

outputs: []
