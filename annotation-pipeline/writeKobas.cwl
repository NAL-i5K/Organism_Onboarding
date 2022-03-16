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
  inputFile_Path:
    type: string
  inputFile_Name:
    type: string
  K_input_Species:
    type: string
  K_inputFile_Type:
    type: string
  K_output_Name:
    type: string
  K_database_Dir:
    type: string
arguments:
  - position: 1
    valueFrom: "echo 'kobas -a -i $(inputs.inputFile_Path)/$(inputs.inputFile_Name) -s $(inputs.K_input_Species) -t $(inputs.K_inputFile_Type) -o $(inputs.K_output_Name) -k $(inputs.K_database_Dir)' >> sbatch_file.sh"  

outputs: 
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"


