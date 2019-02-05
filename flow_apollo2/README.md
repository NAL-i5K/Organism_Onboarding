# flow_apollo2
## Usage
```
cwl-runner apollo2-workflow.cwl job.yml
```

## Testing example
- **old.fa**:


 
## File explanation :tada:
- **block** : It is the basic functional structure, like a building brick. I copy from block_sample if I develope a new block.
- **demo_workflow**: These demo directory try to see how the connecting block work, and the most important file is \*-workflow.cwl. Other cwl files are copy from block\* folder.
- **storage**: It is a recycle bin.  
- **flow_apollo2**: I break down the apollo2 onstage step in data wrangling into 11 CWL steps. <br>
[Here is the link of original shell script file](https://gitlab.com/i5k_Workspace/apollo2_data_build_scripts/blob/master/build_apollo2_flatfiles.sh)

## Miscellaneous :rocket:
- One thing worth mentioning when developing, so not write to many comment in cwl files, it may probably cause permanentfail.

