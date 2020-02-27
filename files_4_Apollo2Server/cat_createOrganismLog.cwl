#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_createOrganismLog)];
        return LIST;
      }
  
inputs:
  in_createOrganismLog:
    type: File

baseCommand: [cat]
arguments:
  - position: 1
    valueFrom: $(inputs.in_createOrganismLog)

outputs: []

