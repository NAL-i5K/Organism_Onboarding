#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = inputs.in_gz;
        LIST.push(inputs.in_txt2);
        return LIST;
      }
baseCommand: [md5sum]

arguments: 
  - position: 1
    prefix: -c
    valueFrom: $(inputs.in_txt2.basename)
 
inputs:
  in_gz:
    type: File[] 
  in_txt2:
    type: File

outputs: 
  out_check_log:
    type: stderr
stderr:
  ${
    var X = (inputs.in_txt2);
    return X.nameroot + '.log';
  }

