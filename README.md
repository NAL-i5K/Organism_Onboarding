:+1: :camel: :tada: :metal:
# CWL, Common-Workflow-Language 
## What is CWL? :octocat:
- a tool to make our organism onboarding pipeline easy to maintain
- design functional blocks, and concatenate them to make a complete working pipeline
- an I/O pipeline

## How does CWL look like?
- All **<.cwl>** files are same between organism, and **<.yml>** file need to be customize for specific organism.
=============================================================================
##  Ultimate goal
- finish all works with only one single command
```
cwl-runner workflow.cwl job.yml
```
=============================================================================
- __block_* __: the basic starting structure of building block. I copy from block_sample if I develope a new block.
- __demo_workflow* __: These demo directory try to see how the connecting block work, and the most important file is \*-workflow.cwl. Other cwl files are copy from block\* folder.
- **storage**: It is a recycle bin.  


## Miscellaneous
- One thing worth mentioning when developing, so not write to many comment in cwl files, it may probably cause permanentfail.

