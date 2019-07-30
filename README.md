# Organism Onboarding 
- Implemented by Common Workflow Language(CWL), which is a python package.
- The main principle: 
  - When working on multiple organisms one after another, keep .cwl files the same, and do customize yml file for specific organism (for example, file **job-apimel.yml** for honeybee).
  - To put it in another way, all organisms share the same **<.cwl>** files, and a single **<.yml>** file need to be customized for every single specific organism.
  

# User guide :metal:

### Prerequisite
- Python 2.7 or 3.x {x = 4, 5, 6, 7}
- A text editor for editting yml file

### Getting started step by step
- Step1. Clone and setup 
```
git clone https://github.com/NAL-i5K/Organism_Onboarding.git
cd Organism_Onboarding/
```

```
./setup.sh
```

- Step2. Create a file
Create a file named it **job-[gggsss].yml** for the specific organism. Take **example.yml** as reference.  

- Step3.  
```
cwl-runner --enable-ext final-workflow.cwl job-[gggsss].yml &> [gggsss].CWLlog
```

- Step4.  
Finish!


# Developer guide :rocket:
### File explanation
- **final-workflow.cwl** : The biggest workflow, which is nested workflow(workflow of workflow). [https://www.commonwl.org/user_guide/22-nested-workflows/index.htm]( https://www.commonwl.org/user_guide/22-nested-workflows/index.html)
- **flow_apollo2_data_processing** : I break down the apollo2 onstage step in data wrangling into several steps.   
[Here is the link of original shell script file, build_apollo2_flatfiles.sh ](https://gitlab.com/i5k_Workspace/apollo2_data_build_scripts/blob/master/build_apollo2_flatfiles.sh)


### Some tips
- Design functional blocks(CommandLineTool), and concatenate them to make a complete working pipeline(Workflow).  

- An Input/Output pipeline.  

- A good user guide to study writing CWL ->  
https://www.commonwl.org/user_guide/

- Writing CWL is like building a castle by LEGO, block by block.  

- Have fun :)
