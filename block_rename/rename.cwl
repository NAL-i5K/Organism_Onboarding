#!/usr/bin/env cwl-runner

#Given a File array, find a file name ended with "_updated.gff" and change its name.

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_rename)
        writable: true

baseCommand: [mv]
arguments: 
  - valueFrom: $(inputs.in_rename.basename)
  - valueFrom: 
      ${
        var str = (inputs.in_rename.nameroot);
        var index_underscore = 0;
        var index_first = 0;
        var index_second = 0;
        var first = 0;
        var second = 0;
        for (var i = str.length; i >= 0; i--) {
          if (str[i] == '_') {
            index_underscore = i;
            index_second = i-1;
            second = parseInt(str[index_second]);
            index_first = i-3;
            first = parseInt(str[index_first]);
            if (second == 9) {
              first = first + 1;
              second = 0;
            }
            else {
              second = second + 1;
            }
            break;
          }
        }
        return str.slice(0, index_first) + first + '.' + second + '.gff';
      }
        # (e.g.) *_v1.3_updated
        # index_first: the index number of '1'
        # index_second: the index number of '3'
        # index_underscore: the index number of the underscore between version number and 'updated'

inputs: 
  in_rename:
    type: File

outputs: 
  out_rename:
    type: Any
    outputBinding:
      glob: '*'
