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
  inputFile_Path:
    type: string
  G_blast:
    type: string
  G_output_Name:
    type: string
  G_NCBI_Def:
    type: string
  G_identity_Percentage:
    type: int
  G_bitscore:
    type: int
  G_databaseQuery_ID:
    type: string
  G_name_OnOutput:
    type: string
  G_NCBI_taxonID:
    type: string
arguments:
  - position: 1
    valueFrom: "echo 'goanna -a $(inputs.G_blast) -c $(inputs.inputFile_Path) -o $(inputs.G_output_Name) -$(inputs.G_NCBI_Def) -g $(inputs.G_identity_Percentage) -s $(inputs.G_bitscore) -d $(inputs.G_databaseQuery_ID) -u $(inputs.G_name_OnOutput) -x $(inputs.G_NCBI_taxonID)' >> sbatch_file.sh"  

outputs: 
  Script_file:
    type: File
    outputBinding:
      glob: "*.sh"


