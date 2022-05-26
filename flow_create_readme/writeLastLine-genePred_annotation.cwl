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
  readme_file:
    type: File
  original_gff:
    type: File
  processed_gff:
    type: File
   
arguments:
  - position: 1
    valueFrom: "echo -e '\nThe file $(inputs.original_gff.basename) was post-processed to add functional annotations from the AgBase functional annotation pipeline (https://github.com/agbase). The resulting file is: $(inputs.processed_gff.basename). This file was used for all operations within the i5k Workspace.' >> readme.txt"

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
