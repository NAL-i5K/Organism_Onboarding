# CWL, Common-Workflow-Language
- CWL is a workflow tool to make organism onboarding pipeline easier to handle as an I/O pipeline
- We aim to design some functional blocks, and concatenate them to make a complete working pipeline
- A single block in CWL language is composed of two files, that is, **<.cwl>** file + **<.yml>** file

=============================================================================
- production directory: the code which is okay to be used in the pipeline, and the code in this directory is just the copy from other block.  
- storage directory: the code which is not used in pipeline,  but is still function
- block directory: the code still under development
