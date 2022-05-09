#!/usr/bin/env perl
use strict;
use warnings;

my $go = shift @ARGV or die;#GAF output from agbase combine-gafs
my $kegg = shift @ARGV or die;#Kegg output from agbase, format acc_pathways
my $gff = shift @ARGV or die;#refseq-based gff of annotations that the functional annotations were performed on. (although note that the protein fasta file is typically used)
my $table = shift @ARGV or die;#refseq-based feature table

#prints to STDOUT

#1. from feature table, create hash %ids of mRNA accession numbers (keys, CDS line position 12/column 13) and protein accession numbers (value, CDS line position 10/column 11). If there is no mRNA accesssion number (this should happen with mtDNA - who knows, perhaps there are other cases), then use the locus tag (position 16/column 17) as the key. 

my %ids = ();
my $counter0 = 0;
open ( my $TABLE, $table ) or die "can't open $table\n";
while ( my $line = <$TABLE> ){
    chomp $line;
    next if ( $line =~ /^#/ );#avoid header
    my @array = split /\t/, $line;
    if ( defined $array[12] ){
	$ids{$array[12]} = $array[10];
	$counter0++;
    }
    else {
	warn "mRNA accession number $array[12] not defined - using locus tag $array[16] instead:\n$line\n";
	$ids{$array[16]} = $array[10];
	$counter0++;
    }
}
close $TABLE;
warn "found $counter0 accession numbers in $table\n";

#2. from GAF file, create hash %go of go annotations - key is protein accession, value is comma-separated list of GO accessions

my %go = ();
my %check_go = ();#use this to eliminate dups in earlier versions of goanna
open ( my $GO, $go ) or die "Can't open $go\n";
while ( my $line = <$GO> ){
    chomp $line;
    next if ( $line =~ /^!/ );#avoid header                                                                   
    my @array = split /\t/, $line;
    $check_go{$array[1]} -> {$array[4]} = $array[4];
}
close $GO;

foreach my $key ( keys %check_go ){
    foreach my $key2 ( keys %{$check_go{$key}} ){
	if ( defined $go{$key} ){
	    $go{$key} .= ",".$check_go{$key}{$key2};
	}
	else {
	    $go{$key} .= $check_go{$key}{$key2};
	}
    }
}

#3. from KEGG file, create hash %kegg of kegg annotations - key is protein accession, value is comma-separated list of KEGG accessions 

#KEGG:dme04310,Reactome:R-DME-195721,Reactome:R-DME-4608870,Reactome:R-DME-162582,Reactome:R-DME-4086400,Reactome:R-DME-3858494

my %kegg = ();
open ( my $KEGG, $kegg ) or die "can't open $kegg\n";
while ( my $line = <$KEGG> ){
    chomp $line;
    my @array = split /\t/, $line;
    $kegg{$array[0]} = $array[1];
}
close $KEGG;

#4. Read gff. 
#For mRNA lines, find trancript_id value and get corresponding protein id from %ids hash.  Use protein ID to get GO and KEGG annotations from %go and %kegg hashes. Add to Ontology_term attribute
#For CDS lines, find protein_id value, use to get GO and KEGG annotations from %go and %kegg hashes. Add to Ontology_term attribute
#add appropriate header line that lists where the functional annotations came from
#print out to new file named in the following format ...
my $go_counter = 0;
my $kegg_counter = 0;
my $counter = 0;
open ( my $GFF, $gff ) or die "can't open $gff\n";
while ( my $line = <$GFF> ){
    chomp $line;
    if ( $line =~ /^#/ ){
	print STDOUT "$line\n";
    }
    else {
	$counter++;
	if ( $counter == 1 ){#add pragma
	    print STDOUT "##Gene Ontology (GO) annotations are derived from agbase/goanna:2.2 (https://hub.docker.com/repository/docker/agbase/goanna) with ECO:0000247 or from agbase/interproscan:5.45-80 (https://hub.docker.com/repository/docker/agbase/interproscan) with ECO:0000501\n##Pathway annotations are derived from agbase/kobas:3.0.3_0 (https://hub.docker.com/repository/docker/agbase/kobas) with ECO:0000247";
	}
	my @array = split /\t/, $line;
	if ( $array[2] =~ /^mRNA$/ ){
	    if ( $array[8] =~ /transcript_id=([^;]+);*/ ){
		my $tid = $1;
		if ( defined $ids{$tid} ){
		    my $pid = $ids{$tid};
		    if ( defined $go{$pid} ){
                       if ( $line =~ /Ontology_term=/ ){                                              
                           $line =~ s/Ontology_term=/Ontology_term=$go{$pid},/;                      
                       }                                                                               
                       else {                                                                          
                           $line .= ";Ontology_term=$go{$pid};";                                      
                       }                                                                               
			$go_counter++;
		    }
		    if ( defined $kegg{$pid} ){
                        if ( $line =~ /Ontology_term=/ ){
                            $line =~ s/Ontology_term=/Ontology_term=$kegg{$pid},/;
                        }
                        else {
                            $line .= ";Ontology_term=$kegg{$pid};";
                        }
			$kegg_counter++;
		    }
		}
		else {
		    warn "can't find corresponding protein ID for transcript id $tid. You need to look into this.\n";
		}
	    }
	}
	elsif ( $array[2] =~ /^CDS$/ ){
	    if ( $array[8] =~ /protein_id=([^;]+);*/ ){
                my $pid = $1;
                if ( defined $go{$pid} ){
                    if ( $line =~ /Ontology_term=/ ){
                        $line =~ s/Ontology_term=/Ontology_term=$go{$pid},/;
                    }
                    else {
                        $line .= ";Ontology_term=$go{$pid};";
                    }
		    $go_counter++;
                }
                if ( defined $kegg{$pid} ){
                    if ( $line =~ /Ontology_term=/ ){
                        $line =~ s/Ontology_term=/Ontology_term=$kegg{$pid},/;
                    }
                    else {
                        $line .= ";Ontology_term=$kegg{$pid};";
                    }
		    $kegg_counter++;
                }
            }
	}
	$line =~ s/;;/;/;
	print STDOUT "$line\n";
    }
}

warn "Added GO terms to $go_counter mRNA and CDS lines and KEGG terms to $kegg_counter mRNA and CDS lines\n"; 
