#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bash, -c] 
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      ${
        var LIST = [(inputs.yml_file)];
        return LIST;
      }
   
inputs:
  yml_file:
    type: File
  scientific_name:
    type: string[]
  PATH: 
    type: string[]
  tree:
    type: string[]
  managePy_Path:
    type: string
  blastdb_Path_production:
    type: string[]
  hmmerdb_Path_production:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  deepPATH_analyses:
    type: string[]
  genome_fasta_name:
    type: string[]
  transcript_fasta_name:
    type: string[]
  cds_fasta_name:
    type: string[]
   

arguments:
  - position: 1
    valueFrom: "echo -e 'scientific_name: $(inputs.scientific_name)\ntree: $(inputs.tree)\nmanagePy_Path: $(inputs.managePy_Path)\nblastdb_Path: $(inputs.blastdb_Path_production)\nhmmerdb_Path: $(inputs.hmmerdb_Path_production)\nin_fasta:\n  class: File\n  path: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.genome_fasta_name[0])\nin_fasta_transcript:\n  class: File\n  path: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])/$(inputs.transcript_fasta_name[0])\nin_fasta_cds:\n  class: File\n  path: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])/$(inputs.cds_fasta_name[0])\nin_fasta_protein: [' >> genomics-workspace.yml"  

outputs: 
  Yml_file:
    type: File
    outputBinding:
      glob: "*.yml"
