#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
#      - entry: 
      ${
        var LIST = (inputs.in_tree);
        LIST = LIST.encode('utf-8')
        return LIST;
      }

baseCommand: [touch]
arguments: 
  - position: 1
    valueFrom: 'haha'
  - position: 2
    valueFrom: '|'
  - position: 3
    valueFrom: mv
  - position: 4
    valueFrom: 'apollo'
  - position: 5
    valueFrom: 'aaa'
inputs:
  in_tree:
    type: Directory
  in_apollo:
    type: Directory
outputs: []
