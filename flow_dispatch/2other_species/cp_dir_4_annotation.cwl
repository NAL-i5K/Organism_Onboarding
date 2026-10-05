#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
requirements:

        class: InlineJavascriptRequirement
        class: LoadListingRequirement
        loadListing: no_listing

baseCommand: [cp, -r, -T]
arguments:

        position: 1
        valueFrom: $(decodeURIComponent(inputs.in_data.location.slice(7)))
        position: 2
        valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_1[0])/$(inputs.deepPATH_2[0])/$(inputs.tree[3])
    inputs:
        PATH:
        type: string[]
        tree:
        type: string[]
        deepPATH_1:
        type: string[]
        deepPATH_2:
        type: string[]
        in_data:
        type: Directory
    outputs: []
