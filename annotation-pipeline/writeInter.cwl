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
  I_output_Name:
    type: string
  I_output_fileFormat:
    type: string
  I_name_OnOutput:
    type: string
  I_taxonID:
    type: string
  I_database:
    type: string
arguments:
  - position: 1
    valueFrom: "echo 'agbase_interproscan -i $(inputs.inputFile_Path)/$(inputs.inputFile_Name) -d $(inputs.I_output_Name) -f $(inputs.I_output_fileFormat) -g -p -n $(inputs.I_name_OnOutput) -x $(inputs.I_taxonID) -D $(inputs.I_database)' >> sbatch_file.sh"  

outputs: 
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"


