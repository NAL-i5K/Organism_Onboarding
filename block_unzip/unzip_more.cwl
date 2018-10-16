# Ref: Returning_Output_files
# success one input .gff.gz file and [gzip, -d] to create a .gff output
# Try to investigate listing part and staging
# 
#!/usr/bin/env cwl-runner

label : to decompress the gzip file
cwlVersion: v1.0
class: CommandLineTool
#requirements:
#  - class: InlineJavascriptRequirement
#  - class: InitialWorkDirRequirement
    #listing: 
    #  - entry: $(inputs.in)
#    listing: $(inputs.files) #for type:File[]
baseCommand: [gzip, -cd]

inputs: []
   
arguments:
  - valueFrom: $(runtime.tmpdir.GCF_002532875.1_vjacob_1.0_genomic.gff.gz)

#  in:
#    type: string
#    inputBinding:
#      position: 1
#      valueFrom: '*.gz'
      #valueFrom: $(self.basename) #default

outputs:
  out:
    type: stdout
#    secondaryFiles:
#      - .gff
#      - .fna
stdout: '*'

#Note:
#InlineJavascriptRequirement
#for example, the name of input file is EXAMPLE.gff.gz
#"basename": "EXAMPLE.gff.gz",
#"nameroot": "EXAMPLE.gff",
#"nameext": ".gz"
