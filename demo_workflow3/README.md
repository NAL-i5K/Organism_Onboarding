# Usage
block_wget --> block_gunzip
```
cwl-runner 1st-workflow.cwl block_wget/wget-job.yml
```

# Equivalent command: 
none

# Gerneral description:
  demo_workflow is used to demo how two blocks connect.  
First block: input string[], output File.  
Second block: input File, output File.  

