#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: johnbamboobilly/demo_docker
baseCommand: [touch]
arguments: 
  - position: 1
    valueFrom: 'docker.txt'
inputs: []
outputs: 
  out_sample:
    type: File
    outputBinding:
      glob: '*'
