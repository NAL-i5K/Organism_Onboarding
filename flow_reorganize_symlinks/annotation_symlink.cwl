#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    #functional annotation directory
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[3])
    #target directory
  - position: 2
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/2.Official or Primary Gene Set/.

inputs:
  in_dummy: 
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]
  scientific_name: 
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  deepPATH_analyses:
    type: string[]
  MAIN_PATH:
    type: string

outputs:
  out_dummy:
    type: stdout
stdout: annotation_symlink.dummy
