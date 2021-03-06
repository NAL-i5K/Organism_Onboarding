#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bash, -c] 
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = [(inputs.readme_file)];
        return LIST;
      }
   
inputs:
  in_dummy:
    type: File[]
  readme_file:
    type: File
  tree:
    type: string[]
  link_to_publication:
    type: string

   
arguments:
  - position: 1
    valueFrom: "echo -e '\nInformation about this dataset can be found here: https://i5k.nal.usda.gov/content/ncbi-${ var A = inputs.tree[2].toLowerCase().replace(/_/g, '-'); return A; }\nInformation about the publication of this dataset can be found here: $(inputs.link_to_publication)' >> readme.txt"

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
