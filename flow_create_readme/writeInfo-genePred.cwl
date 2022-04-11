#!/usr/bin/env cwl-runner

cwlVersion: v1.2
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
    type: File
  readme_file:
    type: File
  tree:
    type: string[]
  link_to_publication:
    type: string

   
arguments:
  - position: 1
    valueFrom: "echo -e '\nInformation about this dataset can be found here: \nInformation about the publication of this dataset can be found here: $(inputs.link_to_publication)' >> readme.txt"

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
