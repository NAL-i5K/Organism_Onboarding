# Organism Onboarding
- Adding an organism to the i5k Workspace NAL requires a lot of work. Doing it manually may take you planty of time. This repository provides a couple of workflows for antomatically running the complicated steps of adding a new organism. 
- There are six main workflows in this repo. **[final-workflow.cwl], [MoveData-workflow], [apolloServer-createOrganism-workflow], [genomics-workspace.cwl], [CreateSymlink-workflow], [annotation-pipeline]**. All of them are suppossed to be run on our server(apollo-stage, apollo-production, gmod-stage and gmod-production). You can find the introduction of each workflow on this wiki page. (https://gitlab.com/i5k_Workspace/workspace_roadmap/-/wikis/Organism_Onboarding-Instruction#createsymlink-workflow) 
- This repo is implemented by Common Workflow Language(CWL), which is a python package.
- The main principle: 
  - When working on multiple organisms one after another, keep .cwl files the same, and do customize yml file for specific organism (for example, file **job-apimel.yml** for honeybee).
  - To put it in another way, all organisms share the same **<.cwl>** files, and a single **<.yml>** file need to be customized for every single specific organism.
  

# User guide :metal:

### Prerequisite
- Python 3.x {x = 4, 5, 6, 7}  
check by command  ```python --version```  

### Getting started step by step 
Typically, there are four steps for using these workflow. **1.** clone the requied repositories **2.** acitivte virtual env for cwltool **3.** edit the yml file **4.** run cwl workflow

- **Step1.**    
Clone the repositories on your working directory on NAL servers. Running these workflows requires the following programs. You will need to clone the these repositories and add them to path on NAL servers before you run these workflow. You can follow the instruction on this wiki page. (https://gitlab.com/i5k_Workspace/workspace_roadmap/-/wikis/Environment-setup-on-the-NAL-servers)
1. Organism_Onboarding (This repo)
2. content_onboarding_scripts
3. wiggle-tools
4. bam_to_bigwig
5. ColorByType
```
git clone https://github.com/NAL-i5K/Organism_Onboarding.git
git clone https://github.com/NAL-i5K/content_onboarding_scripts.git
git clone https://github.com/NAL-i5K/wiggle-tools.git
git clone https://github.com/NAL-i5K/bam_to_bigwig.git
git clone https://github.com/NAL-i5K/ColorByType.git
```

- **Step2.**  
Go into the virtual environment of cwl  
```
cd Organism_Onboarding/
source /app/data/cwltool/venv/bin/activate
```

- **Step3.**  
Create and named your yml file **job-[gggsss].yml** for the specific organism. You can take **example.yml** as a reference.  
```
cp example.yml job-[gggsss].yml
vim job-[gggsss].yml
```  

- **Step4.**  
Run cwl and document the message throwed by cwl in a file. The first workflow to run is 'final-workflow.cwl' which supposed to be run on apollo-stage. 
```
cwl-runner --enable-ext final-workflow.cwl job-[gggsss].yml &> [gggsss].CWLlog
cwl-runner --enable-ext MoveData-workflow.cwl job-[gggsss].yml &> [gggsss]-MoveData.CWLlog
cwl-runner --enable-ext apolloServer-createOrganism -workflow.cwl job-[gggsss].yml &> [gggsss]- apolloServer-createOrganism.CWLlog
cwl-runner --enable-ext flow_genomicsWorkspace/genomics-workspace.cwl genomics-workspace.yml &> [gggsss]-genomics-workspace.CWLlog
cwl-runner --enable-ext CreateSymlink.cwl job-[gggsss].yml &> [gggsss]-CreateSymlink.CWLlog
cwl-runner --enable-ext annotation-pipeline/workflow.cwl job-[gggsss].yml &> [gggsss]- annotation-pipeline.CWLlog
```

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
