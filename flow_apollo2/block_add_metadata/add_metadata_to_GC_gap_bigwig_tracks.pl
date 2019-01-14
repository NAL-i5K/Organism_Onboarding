#!/usr/bin/env perl -w
use strict;

#PURPOSE: adds metadata stanzas to i5k workspace Gap and GC content bigwig tracks in jbrowse trackList.json files
#specifically, searches for  "urlTemplate" : "bigwig/$file" and adds metadata after that
#old tracklist is copied to user-specified file, new info writes to working trackList.json file

my $tl = shift @ARGV or die; #path to tracklist
my $backup =  shift @ARGV or die;#path to backup file (current tracklist will be moved there)
my $gc = shift @ARGV or die; #name of gc content bigwig NOT PATH
my $gap = shift @ARGV or die; #name of gap bigwig NOT PATH

my $gc_metadata = "\t\"category\" : \"Reference Assembly\",\n\t\t\"metadata\" : \{\n\t\t\"Track description\" : \"This track was created as part of the data proccessing workflow used to create the Web Apollo instance.\",\n\t\t\"Track legend\" : \"Visualization of GC/AT content in the reference assembly.  Bases called as G or C are scored 1 and colored blue; A and T bases are scored 0 and colored yellow. Ambiguous bases (N) are left blank. At zoom levels in which individual bases can not be resolved, scores are averaged for visualization. The pivot point is 0.5, or 50% G+C or A+T. The score at any position may be seen by moving the cursor to that position in the track.\",\n\t\t\"Track contact\" : \"The i5k workspace\@NAL\"\n\t\t}";

my $gap_metadata = "\t\"category\" : \"Reference Assembly\",\n\t\t\"metadata\" : {\n\t\t\"Track description\" : \"This track was created as part of the data proccessing workflow used to create the Web Apollo instance.\",\n\t\t\"Track legend\" : \"Visualization of gaps in the reference assembly.  Basecalls of N are colored black. All other regions are left blank\",\n\t\t\"Track contact\" : \"The i5k workspace\@NAL\"\n\t\t}";

warn "backing up $tl to $backup\n";
print `cp $tl $backup`;

warn "writing new metadata to $tl\n";

open ( my $TL, $backup ) or die "can't open $backup\n";
open ( my $OUT, ">$tl" ) or die "can't open $tl\n";
while ( my $line = <$TL> ){
    chomp $line;
    if ( $line =~ /"urlTemplate" : "bigwig\/$gc"/ ){
	if ( $line =~ /,$/ ){
	    print $OUT "$line\n$gc_metadata,\n";
	}
	else {
            print $OUT "$line\n$gc_metadata\n";
	}
    }
    elsif ( $line =~ /"urlTemplate" : "bigwig\/$gap"/ ){
	if ( $line =~ /,$/ ){
	    print $OUT "$line\n$gap_metadata,\n";
	}
	else {
	    print $OUT "$line\n$gap_metadata\n";
	}
    }
    else {
	print $OUT "$line\n";
    }
}
close $TL;
exit;
