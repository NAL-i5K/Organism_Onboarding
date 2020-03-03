#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bash, -c] 
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

arguments:
  - position: 1
    valueFrom: "echo '#This yml file is used for genomics-workspace workflow' > genomics-workspace.yml"  

outputs: 
  Yml_file:
    type: File
    outputBinding:
      glob: "*.yml"
