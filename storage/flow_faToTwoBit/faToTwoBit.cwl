#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement

inputs: 
  in_faToTwoBit_tree: Directory

steps:
  step_wget_faToTwoBit:
    run: wget_faToTwoBit.cwl
    in: []
    out: 
      [out_wget_faToTwoBit] 
  step_cp_faToTwoBit:
    run: cp_faToTwoBit.cwl
    in: 
      in_faToTwoBit_tree: in_faToTwoBit_tree
      in_faToTwoBit: step_wget_faToTwoBit/out_wget_faToTwoBit
    out:
      []
outputs: []
