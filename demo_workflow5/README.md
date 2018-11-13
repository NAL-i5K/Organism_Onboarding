# Usage
```
cwl-runner 1st-workflow.cwl block_wget/wget-job.yml
```

block_wget --> block_check_checksum --> (if the checksum pass) --> block_gunzip
(if the check not pass) ??

# Equivalent command: 
none

# Gerneral description:

  demo_workflow is used to demo how blocks connect.  
temp: the files is not useful
First block: input string[], output File[].  
Second block: 
Third block: input File[], output File[].  


