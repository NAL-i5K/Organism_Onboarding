#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [gzip]
arguments:
  - prefix: '-9'
    #fasta file
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.genome_fasta_name[0])
    
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

outputs:
  out_dummy:
    type: stdout
stdout: scaffold_gzip.dummy 
