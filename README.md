# CWL, Common-Workflow-Language
- CWL is a workflow tool to make organism onboarding pipeline easier to handle as an I/O pipeline
- We aim to design some functional blocks, and concatenate them to make a complete working pipeline
- A single block in CWL language is composed of at least one **<.cwl>** files, and some blocks with a **<.yml>** file
- One thing worth mentioning when developing, so not write to many comment in cwl files, it may probably cause permanentfail.
=============================================================================
- **demo_workflow directory**: see how the connecting block work. Every block inside the folder is a copy from the same level directtory.
- **block_sample**: the basic starting structure of building block. I copy from block_sample if I develope a new block.
- **flow_**: basically contain more than one block, but express a function.  
- **storage directory**: It is a recycle bin.  
