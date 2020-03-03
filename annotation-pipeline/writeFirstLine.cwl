#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bash, -c] 
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = [(inputs.scriptFile)];
        return LIST;
      }
   
inputs:
  scriptFile:
    type: File

arguments:
  - position: 1
    valueFrom: "echo '#! /bin/bash' > sbatch_file.sh"  

outputs: 
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"


