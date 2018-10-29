# Usage
block_wget --> block_rename 
```
cwl-runner 2nd-workflow.cwl block_wget/wget-job.yml
```

# Equivalent command: 
none

# Gerneral description:
  demo_workflow is used to demo how two block connect.  
First block: input string, output File.  
Second block: input File which produced last block, output renamed File.  

# File description:
**1st-workflow.cwl**: just run the block_wget.  
**2nd-workflow.cwl**: run the block_wget, and then block_rename.  
 
