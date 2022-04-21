#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: SubworkflowFeatureRequirement

inputs:
  PATH: string[]
  tree: string[]
  scientific_name: string[]
  genome_fasta_name: string[]
  protein_fasta_name: string[]
  transcript_fasta_name: string[]
  cds_fasta_name: string[]
  gff_name: string[]
  deepPATH_genomic_fasta: string[]
  deepPATH_analyses: string[]
  deepPATH_bigwig: string[]
  MAIN_PATH: string
  
steps:
  #step1 setup folder
  setup_folder:
    run: flow_reorganize_symlinks/setup_folder.cwl
    in:
      MAIN_PATH: MAIN_PATH
      tree: tree     
      scientific_name: scientific_name
    out: [out_dummy]
  #step2 gzip - scaffold file
  gzip-conditional:
    in:
      genome_fasta_name: genome_fasta_name
      PATH: PATH
      tree: tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
    out: [gzip_string]
    run:
      class: CommandLineTool
      stdout: conditional-gzip
      baseCommand: find
      arguments:
        - position: 1
          valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/
        - position: 2
          prefix: -name
          valueFrom: "$(inputs.genome_fasta_name[0]).gz"
      inputs:
        genome_fasta_name:  
          type: string[]
        PATH:
          type: string[]
        tree:
          type: string[]
        deepPATH_genomic_fasta:
          type: string[]
      outputs:
        gzip_string: 
          type: string
          outputBinding:
            glob: conditional-gzip
            loadContents: true
            outputEval: $(self[0].contents)
  scaffold_gzip:
    run: flow_reorganize_symlinks/scaffold_gzip.cwl
    when: $(inputs.gzip_string == "")
    in:
      in_dummy: setup_folder/out_dummy
      gzip_string: gzip-conditional/gzip_string
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
    out: [out_dummy] 
  #step3 symlink - scaffold file
  scaffold_symlink:
    run: flow_reorganize_symlinks/scaffold_symlink.cwl
    in:
      in_dummy: scaffold_gzip/out_dummy
      PATH: PATH
      tree: tree
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      MAIN_PATH: MAIN_PATH
    out: [out_dummy]
  #step4 symlink - analyses_protein files
  analyses_symlink_protein:
    run: flow_reorganize_symlinks/analyses_symlink_protein.cwl
    in:
      in_dummy: scaffold_symlink/out_dummy
      PATH: PATH
      tree: tree
      scientific_name: scientific_name
      protein_fasta_name: protein_fasta_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      MAIN_PATH: MAIN_PATH
    out: [out_dummy]
  #step5 symlink - analyses files
  analyses_symlink:
    run: flow_reorganize_symlinks/analyses_symlink.cwl
    in:
      in_dummy: analyses_symlink_protein/out_dummy
      PATH: PATH
      tree: tree
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      transcript_fasta_name: transcript_fasta_name
      cds_fasta_name: cds_fasta_name
      gff_name: gff_name
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      deepPATH_analyses: deepPATH_analyses
      MAIN_PATH: MAIN_PATH
    out: [out_dummy]
  #step6 gzip - bigwig files
  bigwig_gzip:
    run: flow_reorganize_symlinks/bigwig_gzip.cwl
    in:
      in_dummy: analyses_symlink/out_dummy
      PATH: PATH
      tree: tree
      genome_fasta_name: genome_fasta_name
      deepPATH_bigwig: deepPATH_bigwig
    out: [out_dummy]
  #step7 symlink - bigwig files-gaps
  bigwig_symlink-gaps:
    run: flow_reorganize_symlinks/bigwig_symlink-gaps.cwl 
    in:
      in_dummy: bigwig_gzip/out_dummy
      PATH: PATH
      tree: tree
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      deepPATH_bigwig: deepPATH_bigwig
      MAIN_PATH: MAIN_PATH
    out: [out_dummy]
  #step8 symlink - bigwig files-gc
  bigwig_symlink-gc:
    run: flow_reorganize_symlinks/bigwig_symlink-gc.cwl
    in:
      in_dummy: bigwig_symlink-gaps/out_dummy
      PATH: PATH
      tree: tree
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      deepPATH_bigwig: deepPATH_bigwig
      MAIN_PATH: MAIN_PATH
    out: [out_dummy]
  #step9 symlink - assembly folder
  assembly_symlink:
    run: flow_reorganize_symlinks/assembly_symlink.cwl
    in:
      in_dummy: bigwig_symlink-gc/out_dummy
      tree: tree
      scientific_name: scientific_name
      MAIN_PATH: MAIN_PATH
    out: []
      
      

outputs: []
  
