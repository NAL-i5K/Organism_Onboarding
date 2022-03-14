#!usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  - class: SubworkflowFeatureRequirement

steps:
  delete_id:
    in:
      fasta_file: fasta_file
    out: [id_deleted_file]
    run:
      class: CommandLineTool
      requirements:
        - class: InlineJavascriptRequirement
        - class: InitialWorkDirRequirement
          listing: 
            ${
                var LIST = [(inputs.fasta_file)];
                return LIST;
            }
      stdout: id_deleted_file.txt
      baseCommand: grep
      arguments:
        - position: 1
          prefix: -v
          valueFrom: ">"
        - position: 2
          valueFrom: $(inputs.fasta_file.basename)
      inputs:
        fasta_file: 
          type: File
      outputs:
        id_deleted_file: 
          type: stdout

  gaps-or-not:
    in:
      id_deleted_file: delete_id/id_deleted_file
    out: [gap_lines]
    run:
      class: CommandLineTool
      requirements:
        - class: InlineJavascriptRequirement
        - class: InitialWorkDirRequirement
          listing: 
            ${
                var LIST = [(inputs.id_deleted_file)];
                return LIST;
            }
      stdout: lines-contain-N.txt
      baseCommand: perl
      arguments:
        - position: 1
          prefix: -ne
          valueFrom: 'print if /N/'
        - position: 2
          valueFrom: $(inputs.id_deleted_file.basename)
      inputs:
        id_deleted_file:  
          type: File
      outputs:
        gap_lines: 
          type: stdout

inputs:
  fasta_file: 
    type: File

outputs:
  gap_lines: 
    type: File
    outputSource: gaps-or-not/gap_lines