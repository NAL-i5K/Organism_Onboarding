# flow_apollo2
## Usage
```
cwl-runner apollo2-workflow.cwl testdata/job.yml
```
or
```
cd testdata
cwl-runner ../apollo2-workflow.cwl job.yml
```

## Hint
- the place run the ```cwl-runner``` command is the place be expected output a folder called **data**
<br>
- Make sure to put all the prerequiste in your $PATH

## Prerequisite
- faToTwoBit

- samtools

- jbrowse  
https://github.com/GMOD/jbrowse

- wiggle-tool  
https://github.com/NAL-i5K/wiggle-tools

## Testing example
- **testdata** 
<br>
Download link  
https://github.com/NAL-i5K/GFF3toolkit/tree/master/example_file
<br>
Input list:  
old.fa  
example.gff  
<br>

- **testdata_varjac** 
<br>
Download link  
ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/532/875/GCF_002532875.1_vjacob_1.0
<br>
Input list:  
GCF_002532875.1_vjacob_1.0_genomic.fna  
GCF_002532875.1_vjacob_1.0_genomic.gff  
<br>

 
## Miscellaneous :rocket:

