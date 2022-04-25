#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [gzip]
arguments:
  - prefix: '-9'
    #gc file
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gc.bigwig
  - position: 2
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gaps.bigwig
    
inputs:
  in_dummy: 
    type: File?
  PATH:
    type: string[]
  tree:
    type: string[]
  genome_fasta_name:
    type: string[]
  deepPATH_bigwig:
    type: string[]

outputs:
  out_dummy:
    type: stdout
stdout: bigwig_gzip.dummy
