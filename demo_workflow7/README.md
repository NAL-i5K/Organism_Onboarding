# Usage
```
cwl-runner 1st-workflow.cwl 1st-workflow-job.yml
```
fasta_diff -> gff3_sort -> update_gff ->  gff3_QC ->

# Equivalent command: 
```
fasta_diff example_file/old.fa example_file/new.fa -o match.tsv -r report.txt
```

```
gff3_sort -g example_file/example1.gff3 -og example1_sorted.gff3
```

```
update_gff -a match.tsv example1_sorted.gff3
```

```
gff3_QC -g example1_sorted_updated.gff3 -f example_file/new.fa -o example1_sorted_updated_QC.txt
```


# Gerneral description:
Use the example files in coorinate conversion github repo
Link:
https://github.com/NAL-i5K/coordinates_conversion.git


 
