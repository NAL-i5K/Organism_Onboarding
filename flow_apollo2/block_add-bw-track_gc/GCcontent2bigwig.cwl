#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_dir),
                    (inputs.in_fasta), 
                    (inputs.in_GCcontent2bigwig)];
        return LIST;
      }

baseCommand: [python]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_GCcontent2bigwig.basename)
  - position: 3
    prefix: -o
    valueFrom: $(inputs.in_dir.basename)/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/bigwig/$(inputs.in_fasta.basename).gc.bigwig
  - position : 5
    valueFrom: $(inputs.in_fasta.basename)
    
inputs:
  in_fasta:
    type: File
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_GCcontent2bigwig:
    type: File

outputs: [] 
#  out_GCcontent2bigwig:
#    type: File
#    outputBinding: 
#      glob: '*.gc.bigwig'
