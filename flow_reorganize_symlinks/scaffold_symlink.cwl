#!usr/bin/env cwl-runner

cwlVersion: v1.2
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
  - position: 2  
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/readme.txt
    #target directory
  - position: 3
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/1.Genome Assembly/$(inputs.tree[1])/Scaffolds/.

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
  deepPATH_genomic_fasta:
    type: string[]
  MAIN_PATH:
    type: string

outputs:
  out_dummy:
    type: stdout
stdout: scaffold_symlink.dummy
