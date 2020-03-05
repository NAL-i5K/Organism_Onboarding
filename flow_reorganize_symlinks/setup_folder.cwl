#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

inputs:
  MAIN_PATH:
    type: string
  LINK_DIR: 
    type: string
  ASSEMBLY_NAME:
    type: string
    
baseCommand: [mkdir]
arguments:
  #Genome Assembly
  - position: 1
    prefix: -p
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/1.Genome Assembly/$(inputs.ASSEMBLY_NAME)/agp
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/1.Genome Assembly/$(inputs.ASSEMBLY_NAME)/Contigs
  - position: 3
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/1.Genome Assembly/$(inputs.ASSEMBLY_NAME)/Scaffolds
  #Official or Primary Gene Set
  - position: 4
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/2.Official or Primary Gene Set
  #Additional Gene Sets and Annotation Projects
  - position: 5
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/3.Additional Gene Sets and Annotation Projects
  #Transcriptomes and RNA-Seq
  - position: 6
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/4.Transcriptomes and RNA-Seq
  #Other Files
  - position: 7
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/5.Other files/Gaps in Assembly
  - position: 8
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/5.Other files/GC Content

outputs: 
  out_dummy:
    type: stdout
stdout: setup_folder.dummy
  
    
