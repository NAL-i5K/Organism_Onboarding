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
   
arguments:
  - position: 1
    valueFrom: "echo -e '\nThe file was post-processed to [describe post-processing, if any]. The resulting file is: [Filename]. This file was used for the JBrowse genome browser and the Apollo manual curation tool.' >> readme.txt"

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme.txt"
