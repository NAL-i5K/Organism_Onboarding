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
    valueFrom: "echo -e '\nThe file [file] was post-processed to [describe post-processing, if any]. The resulting file is: [Filename]. This file was used for all operations within the i5k Workspace.' >> readme"  

outputs: 
  readme_file:
    type: File
    outputBinding:
      glob: "readme"
