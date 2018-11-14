# Usage
```
cwl-runner extract_md5checksums.cwl 1st-workflow-job.yml
```

# Equivalent command: 
1> means stdout
```
egrep '<file1>|<file2>|.....|<fileN>' md5checksums.txt 1> md5checksums.txt2
(e.g.)
egrep 'GCF_002532875.1_vjacob_1.0_genomic.gff.gz|GCF_002532875.1_vjacob_1.0_translated_cds.faa.gz' md5checksums.txt 1> md5checksums.txt2
```


# Structure:
**sample file**: description.    

