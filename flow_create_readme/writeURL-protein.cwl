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
  url:
    type: string[]
   
arguments:
  - position: 1
    valueFrom: "echo '$(inputs.url[0])' >> readme.txt"

outputs: 
  out_dummy:
    type: stdout
stdout: url-protein.dummy    
