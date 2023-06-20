#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  
arguments:
  - shellQuote: false
    valueFrom: |-
        # gc file
        gzip -9 $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gc.bigwig
        # If the gaps file exists, compress the gaps file.
        FILE="$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gaps.bigwig"
        if [ -f "$FILE" ]; then
            gzip -9 $FILE
        fi
       
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
