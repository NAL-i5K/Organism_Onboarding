#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

arguments:
  - shellQuote: false
    valueFrom: |-
        FILE="$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_bigwig[0])/$(inputs.genome_fasta_name[0]).gaps.bigwig.gz"
        if [ -f "$FILE" ]; then
            ln -s $FILE "$(inputs.MAIN_PATH)/$(inputs.tree[0])-($(inputs.scientific_name[0])_$(inputs.scientific_name[1]))/$(inputs.tree[1])/5.Other files/Gaps in Assembly/."
        fi
  

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

outputs:
  out_dummy:
    type: stdout
stdout: bigwig_symlink-gaps.dummy
