# Ref: Returning_Output_files
# success one input .gff.gz file and [gzip, -d] to create a .gff output
# Try to investigate listing part and staging
# 
#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [gzip, -dc]
label : to decompress the gzip file
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      - entry: $(inputs.files)
#listing: $(inputs.files) #for type:File[]


inputs:
  files:
    type: File
    inputBinding:
      position: 1
      #valueFrom: $(self.basename) #default
#outputs:
#  out:
#    type: File[]
#    streamable: true
#    outputBinding:
#      glob: $(inputs.files.nameroot)
#stdout: $(inputs.files.nameroot)

outputs:
  out:
    type: stdout
#    secondaryFiles:
#      - .gff
#      - .fna
stdout: $(inputs.files.nameroot)

#Note:
#InlineJavascriptRequirement
#for example, the name of input file is EXAMPLE.gff.gz
#"basename": "EXAMPLE.gff.gz",
#"nameroot": "EXAMPLE.gff",
#"nameext": ".gz"
