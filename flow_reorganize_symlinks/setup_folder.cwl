#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

inputs:
  MAIN_PATH:
    type: string
  tree: 
    type: string[]
  scientific_name: 
    type: string[]
    
baseCommand: [mkdir]
arguments:
  #Genome Assembly
  - position: 1
    prefix: -p
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/1.Genome Assembly/$(inputs.tree[1])/agp
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/1.Genome Assembly/$(inputs.tree[1])/Contigs
  - position: 3
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/1.Genome Assembly/$(inputs.tree[1])/Scaffolds
  #Official or Primary Gene Set
  - position: 4
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/2.Official or Primary Gene Set/$(inputs.tree[2])
  #Additional Gene Sets and Annotation Projects
  - position: 5
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/3.Additional Gene Sets and Annotation Projects
  #Transcriptomes and RNA-Seq
  - position: 6
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/4.Transcriptomes and RNA-Seq
  #Other Files
  - position: 7
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/5.Other files/Gaps in Assembly
  - position: 8
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/5.Other files/GC Content

outputs: 
  out_dummy:
    type: stdout
stdout: setup_folder.dummy
  
    
