# Usage
```
cwl-runner --debug rename.cwl rename-job.yml
```

# Equivalent command: 
```
cp <basename of old file> <new name>
```

mv is excuted in /tmp, and after finish the command, move all the file in output tmp to current dir.
Therefore, actually the effect is look like cp instad of mv

# Structure:

