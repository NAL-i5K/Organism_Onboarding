#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:

steps:
  #step 51
  XXX:
    run: XXX.cwl
    in:
    out:
      []
outputs:
  CCC:
    type: Directory
    outputSource: CCC
