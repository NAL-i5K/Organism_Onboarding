#!/usr/bin/env cwl-runner

cwlVersion: v1.2
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
  inputFile_Name:
    type: string
  I_output_Name:
    type: string
  G_output_Name:
    type: string
  C_output_Name:
    type: string

arguments:
  - position: 1
    valueFrom: "echo 'combine_gafs -i $(inputs.I_output_Name)/$(inputs.inputFile_Name)_gaf.txt -g $(inputs.G_output_Name)_goanna_gaf.tsv -o $(inputs.C_output_Name)' >> sbatch_file.sh"

outputs:
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"
