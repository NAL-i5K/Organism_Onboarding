#! usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [touch]

inputs: []
arguments:
  - position: 1
    valueFrom: sbatch_file.sh

outputs: 
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"
