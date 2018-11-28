#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement

inputs:
  in_wget: string[]
  in_tree: string[]

steps:
  step_wget:
    run: wget.cwl
    in:
      in_wget: in_wget
    out: 
      [out_wget_gz, out_wget_txt]

  step_gunzip:
    run: gunzip-workflow.cwl
    in:
      in_gunzip-workflow: step_wget/out_wget_gz
    out:
      [out_gunzip-workflow]

  step_tree:
    run: tree.cwl
    in:
      in_tree: in_tree
    out:
      [out_tree]

  step_mv:
    run: mv.cwl
    in:
      in_mv_dir: step_tree/out_tree
      in_mv_file: step_gunzip/out_gunzip-workflow
    out:
      [out_mv]

outputs: 
  final_wget_gz:
    type: File[]
    outputSource: step_wget/out_wget_gz

#  final_wget_txt:
#    type: File
#    outputSource: step_wget/out_wget_txt

#  final_gunzip:
#    type: File[]
#    outputSource: step_gunzip/out_gunzip-workflow
    
#  final_tree:
#    type: Directory
#    outputSource: step_tree/out_tree

  final_mv:
    type: Directory 
    outputSource: step_mv/out_mv
