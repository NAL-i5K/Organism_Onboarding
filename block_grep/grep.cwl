#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_grep)
        #entryname: inputDir
        writable: true

baseCommand: [grep]
arguments:
  - position: 1
    valueFrom: 'checksums did NOT match'

inputs: 
  in_grep:
    type: File
    inputBinding:
      position: 2
      valueFrom: $(self.basename)

outputs: 
  out_grep_stdout:
    type: stdout
#  out_grep_stderr:
#    type: stderr
stdout: $(inputs.in_grep.nameroot).stdout
#stderr: $(inputs.in_grep.nameroot).stderr
