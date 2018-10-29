# Usage
```
cwl-runner gitclone-workflow.cwl gitclone-workflow-job.yml
```

# Equivalent command: 
```
git clone <url1>
git clone <url2>
......
git clone <urlN>
```

# Structure:
**gitclone.cwl**: input is a string, output is a directory.
**gitclone-job.yml**: single string. Not use when running scattering workflow.
**gitclone-workflow.cwl**: inputs are string[], output are Directory[].
**gitclone-workflow-job.yml**: writing string[], and each array element is a url.

Wrap the basic **gitclone.cwl** into a bigger workflow, so it excute the basic one for every single element in array and work in separate /tmp file.

# Reference:
## User guide -- Scattering workflow
https://www.commonwl.org/user_guide/23-scatter-workflow/index.html

