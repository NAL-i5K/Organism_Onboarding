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
  organization:
    type: string

arguments:
  - position: 1
    valueFrom: "echo 'The following files were retrieved from $(inputs.organization) on ${var A = new Date(); var year = A.getFullYear(); var month = A.getMonth()+1; var day = A.getDate(); var date = year + '-' + day + '-' + month;  return date;}:' > readme"  

outputs: 
  out_readme_file:
    type: File
    outputBinding:
      glob: "readme"
