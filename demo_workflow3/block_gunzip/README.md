# Usage
Create a directory, called 'data'.
All inside the 'data' directory are all <.gz> files to be decompress.

```
cwl-runner gunzip.cwl gunzip-job.yml
```

After executing, all <.gz> files will disappear

# Equivalent command: 
```
gzip -d <.gz>file1 <.gz>file2 ...... <.gz>fileN
gzip -d {string array}
```

