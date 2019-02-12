#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = inputs.in_gz;
        return LIST;
      }
baseCommand: [gzip]
arguments: 
  - position: 1
    prefix: -df
    valueFrom: $(inputs.in_gz)
inputs:
  in_gz:
    type: File[]
outputs:
  out_genomic_gff:
    type: File
    outputBinding:
      glob: ['*_genomic.gff', '*_genomic.gff3']
  out_genomic_fasta:
    type: File
    outputBinding:
      glob: ['*0_genomic.fna', '*0_genomic.faa', '*0_genomic.fa',
             '*1_genomic.fna', '*1_genomic.faa', '*1_genomic.fa',
             '*2_genomic.fna', '*2_genomic.faa', '*2_genomic.fa',
             '*3_genomic.fna', '*3_genomic.faa', '*3_genomic.fa',
             '*4_genomic.fna', '*4_genomic.faa', '*4_genomic.fa',
             '*5_genomic.fna', '*5_genomic.faa', '*5_genomic.fa',
             '*6_genomic.fna', '*6_genomic.faa', '*6_genomic.fa',
             '*7_genomic.fna', '*7_genomic.faa', '*7_genomic.fa',
             '*8_genomic.fna', '*8_genomic.faa', '*8_genomic.fa',
             '*9_genomic.fna', '*9_genomic.faa', '*9_genomic.fa',
            ]
  out_rna_from:
    type: File
    outputBinding:
      glob: ['*_rna_from_genomic.fna', '*_rna_from_genomic.faa', '*_rna_from_genomic.fa']  
  out_translated_cds:
    type: File
    outputBinding:
      glob: ['*_translated_cds.fna', '*_translated_cds.faa', '*_translated_cds.fa'] 
