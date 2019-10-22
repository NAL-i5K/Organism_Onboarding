#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = [(inputs.in_fasta)];
        return LIST;
      }


baseCommand: [/home/vagrant/genomics-workspace/manage.py]
arguments:
  - position: 1
    valueFrom:
      ${
        var type = inputs.type[0];
        var argument = [];
        if (type == "nucleotide"){
          argument = argument;
        }
        else if (type == "peptide"){
          argument = "addhmmer";
        }
        return argument;
      } 
  - position: 2
    valueFrom:
      ${
        var type = inputs.type[0];
        var argument = [];
        if (type == "nucleotide"){
          argument = argument;
        }
        else if (type == "peptide"){
          argument = inputs.scientific_name[0];
        }
        return argument;
      }
  - position: 3
    valueFrom:
      ${
        var type = inputs.type[0];
        var argument = [];
        if (type == "nucleotide"){
          argument = argument;
        }
        else if (type == "peptide"){
          argument = inputs.scientific_name[1];
        }
        return argument;
      }
  - position: 4
    valueFrom:
      ${
        var type = inputs.type[0];
        var argument = [];
        if (type == "nucleotide"){
          argument = argument;
        }
        else if (type == "peptide"){
          argument = "-f";
        }
        return argument;
      }
  - position: 5
    valueFrom:
      ${
        var type = inputs.type[0];
        var argument = [];
        if (type == "nucleotide"){
          argument = argument;
        }
        else if (type == "peptide"){
          argument = inputs.in_fasta.basename;
        }
        return argument;
      }
inputs:
  in_dummy:
    type: File
  scientific_name:
    type: string[]
  type:
    type: string[]
  in_fasta:
    type: File
outputs:
  out_dummy:
    type: stdout
stdout: addhmmer.dummy
    
