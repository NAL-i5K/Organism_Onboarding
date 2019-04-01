
# CWL, Common-Workflow-Language 
##  Ultimate goal :+1:
- finish all works with only one single command
```
cwl-runner final-workflow.cwl job-[gggsss].yml
```

## Prerequisite
- python 2.7 and 3.x {x = 4, 5, 6, 7}
- a text editor

## Quick start
- Step1.
```pip install cwlref-runner```

- Step2.
Create a file named **job-[gggsss].yml** for the specific organism. Take **example.yml** as reference.

- Step3.  
```
cwl-runner final-workflow.cwl job-[gggsss].yml
```

- Step4.  
Finish!

## What is CWL? :octocat:
- a tool to make organism onboarding pipeline easy to maintain
- design functional blocks, and concatenate them to make a complete working pipeline
- an I/O pipeline

## How does CWL look like? :metal:
- All Organisms share same **<.cwl>** files, and a single **<.yml>** file need to be customize for every single specific organism.

## File explanation :tada:
- **final-workflow.cwl** : Take the cwl file inside flow_* folder, which is basically nested workflow(workflow of workflow).
- **block_*** : The basic functional structure, like a building brick. I always make a copy from block_sample if I develope a new block. 
- **demo workflow** : These demo directory try to see how the connecting block work, and the most important file is -workflow.cwl. Other cwl files are copy from block folder.
- **storage** : It is a recycle bin.  
- **flow_apollo2** : I break down the apollo2 onstage step in data wrangling into several CWL steps.   
[Here is the link of original shell script file](https://gitlab.com/i5k_Workspace/apollo2_data_build_scripts/blob/master/build_apollo2_flatfiles.sh)
<br>
<br>
Related link: https://www.commonwl.org/user_guide/22-nested-workflows/index.html
<br>
<br>
<br>

## How could CWL benefit our organism onboarding pipeline?
![workflow](https://user-images.githubusercontent.com/32384566/52444131-864c1d00-2af5-11e9-8ed3-b2a046d4a50b.PNG)
<br>
![workflow2](https://user-images.githubusercontent.com/32384566/52444010-3bcaa080-2af5-11e9-9555-6b6a202a502a.PNG)

## Miscellaneous :rocket:
- One thing worth mentioning when developing, so not write to many comment in cwl files, it may probably cause permanentfail.

Have fun :)
