# CWL, Common-Workflow-Language
- CWL is a workflow tool to make organism onboarding pipeline easier to handle as an I/O pipeline
- We aim to design some functional blocks, and concatenate them to make a complete working pipeline
- A single block in CWL language is composed of at least one **<.cwl>** files, and some blocks with a **<.yml>** file

=============================================================================
- block_sample: the basic starting structure of building block. I copy from block_sample if I develope a new block.
- production directory: the code which is okay to be used in the pipeline, and the code in this directory is just the copy from other block.  
- storage directory: the code which is not used in pipeline,  but is still function

