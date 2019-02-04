# CWL, Common-Workflow-Language
- CWL is a workflow tool to make organism onboarding pipeline easier to handle as an I/O pipeline
- We aim to design some functional blocks, and concatenate them to make a complete working pipeline
- A single block in CWL language is composed of at least one **<.cwl>** files, and some blocks with a **<.yml>** file
- One thing worth mentioning when developing, so not write to many comment in cwl files, it may probably cause permanentfail.
=============================================================================
- **block_\* **: the basic starting structure of building block. I copy from block_sample if I develope a new block.
- **demo_workflow\* **: These demo directory try to see how the connecting block work, and the most important file is \*-workflow.cwl. Other cwl files are copy from block\* folder.
- **storage**: It is a recycle bin.  
