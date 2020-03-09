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
  readme_file:
    type: File
  tree:
    type: string[]
  accession:
    type: string
  link_to_publication:
    type: string

   
arguments:
  - position: 1
    valueFrom: "echo -e '\nInformation about this dataset can be found here: https://i5k.nal.usda.gov/content/$genus-$species-genome-assembly-$(inputs.tree[1])-$(inputs.accession)\nInformation about the publications of this dataset can be found here: $(inputs.link_to_publication)' >> readme.txt"

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
