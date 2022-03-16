#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.yml_file)];
        return LIST;
      }
 
inputs: 
  yml_file:
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  deepPATH_analyses:
    type: string[]
  protein_fasta_name:
    type: string[]

baseCommand: [bash, -c]
arguments:
  - position: 1
    valueFrom: "echo -e '${
        var A = inputs.protein_fasta_name;
        var B = '{class: File, path: ' + inputs.PATH[0] + '/' + inputs.tree[0] + '/' + inputs.tree[1] + '/' + inputs.deepPATH_genomic_fasta[0] + '/' + inputs.deepPATH_analyses[0] + '/' + inputs.tree[2] + '/';
        var C = [];
        for (var i = 0; i < A.length; i++) {
          C = C + B + A[i] + '}';
          if(i != A.length-1) {
            C = C + ',';
          }
        }
        return C;
      }\n]' >> genomics-workspace.yml"
outputs: 
  Yml_file:
    type: File
    outputBinding:
      glob: "*.yml"
