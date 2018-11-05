# Usage
```
cwl-runner --debug rename.cwl rename-job.yml
```

# Equivalent command: 
Suppose that the version is vX.Y
if Y == 9
```
cp [Assembly Name]_vX.Y_updated.gff [Assembly Name]_v(X+1).0.gff
```
else
```
cp [Assembly Name]_vX.Y_updated.gff [Assembly Name]_vX.(Y+1).gff
```

