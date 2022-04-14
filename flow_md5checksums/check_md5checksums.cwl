#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = inputs.in_gz;
        LIST.push(inputs.in_check);
        return LIST;
      }
baseCommand: [md5sum]

arguments: 
  - position: 1
    prefix: -c
    valueFrom: $(inputs.in_check.basename)
 
inputs:
  in_gz:
    type: File[] 
  in_check:
    type: File

outputs: 
  out_check:
    type: stderr
stderr:
  ${
    var X = (inputs.in_check);
    return X.nameroot + '.log';
  }

