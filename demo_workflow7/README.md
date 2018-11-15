# Usage
```
cwl-runner 1st-workflow.cwl 1st-workflow.yml
```

if the check not pass, pop out completed permanentFail.

extract_checksum: 
input: File[]

check_checksum:
input: from the two previous steps

# Equivalent command: 
wget <url1> <url2> .... <urlN>  

grep <.gz1>|<.gz2>|...|<.gzN> md5checksums.txt 1> md5checksums.txt2  

md5sum -c md5checksums.txt2 1> md5checksums.log
