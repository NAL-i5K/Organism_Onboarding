# Usage
```
cwl-runner --debug md5sum_check.cwl md5sum_check-job.yml
```

# Equivalent command: 
```
md5sum -c md5checksums.txt &> check.log
md5sum -c md5checksums-fake.txt &> check-fake.log
```

```
grep 'checksums did NOT match' check.log
grep 'checksums did NOT match' check-fake.log
```

# Structure:
**md5checksums.txt**: the file form "Download the RefSeq assembly" on NCBI website.    

