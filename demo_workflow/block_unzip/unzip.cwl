#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label : to decompress the gzip file
baseCommand: [gzip, -cd]
requirements:
  - class: InlineJavascriptRequirement

inputs:
  in_unzip:
    type: File
    inputBinding:
      position: 1
      #itemSeparator: ","      
      #valueFrom: $(self.basename) #default

#outputs:
#  out:
#    type: File
#    outputBinding:
#      glob: $(inputs.files.nameroot)

outputs:
  out_unzip:
    type: stdout
stdout: $(inputs.files.nameroot)

#Note:
#InlineJavascriptRequirement
#for example, the name of input file is EXAMPLE.gff.gz
#"basename": "EXAMPLE.gff.gz",
#"nameroot": "EXAMPLE.gff",
#"nameext": ".gz"
