#!/usr/bin/env python
import os
import sys
import subprocess
import tempfile
import re
from optparse import OptionParser
from contextlib import contextmanager

'''
Calculate GC content from a FASTA file and convert it to BigWig file format.(Version 1.2.0)

Usage:
    GCcontent2bigwig.py <FASTA file>
    [-o, --bigwig_filename=<output file name>
     -t, --tempfile
     -k, --keep_tempfile
     -g, --gzip]

Prerequisites:
  ucsc_bigwig: wigToBigWig can be downloaded from UCSC Genome Browser (http://hgdownload.cse.ucsc.edu/admin/exe/)

'''

def main(fasta_filename, bigwig_filename=None, use_tempfile=False, keep_tempfile=False, use_gzip=False):
    if bigwig_filename is None:
        input_file_prefix = os.path.splitext(fasta_filename)[0]
        bigwig_filename = '%s.bigwig' % input_file_prefix

    output_file_prefix = os.path.splitext(bigwig_filename)[0]

    if os.path.abspath(fasta_filename) == os.path.abspath(bigwig_filename):
        sys.stderr.write('Bad arguments, input and output files are the same.\n')
        sys.exit(1)

    # generate wig file
    wig_filename = '%s.wig' % output_file_prefix
    if use_tempfile:
        wig_filename = tempfile.NamedTemporaryFile(delete=False).name
    wig_file = open(wig_filename, "w")

    # generate chromosome sizes file
    chr_sizes_filename = '%s.sizes' % output_file_prefix
    if use_tempfile:
        chr_sizes_filename = tempfile.NamedTemporaryFile(delete=False).name
    chr_sizes = open(chr_sizes_filename, "w")

    base_start_pos = 0
    chromosome = "My_sequence"
    counter = 0
    sizes = dict()
    base_score = {"C":1, "G":1,"S":1,"A":0, "T":0,"W":0}
    code = ["N","R","Y","M","K","H","B","V","D"]
    if use_gzip:
        import gzip
        fp = gzip.open(fasta_filename, "rb")
    else:
        fp = open(fasta_filename, "r")

    for line in fp:
        line = line.strip()
        if len(line) > 0:
            if line[0] == ">":  # in header
                m = re.findall("(?<=>)[\w\-\|.]+", line)
                if m is not None:
                    chromosome = m[0]
                    counter = 0
                    base_start_pos = 0
                    print "Processing %s" % m[0]
                else:
                    print "No chromosome match!"
                    sys.exit(1)
            else:   # in seq.
                for nucl in line:
                    counter+=1
                    sizes[chromosome] = counter # count chromosome size
                    nucl = nucl.upper()

                    if nucl in code:
                        continue
                    else:	#ATCGSW
                        base_start_pos+=1

                        if counter == 1:
                            wig_file.write("fixedStep chrom=%s start=1 step=1 span=1\n" % (chromosome))

                        if base_start_pos != counter: # base_start_pos will not be equal to counter if N bases hit
                            base_start_pos = counter
                            wig_file.write("fixedStep chrom=%s start=%i step=1 span=1\n" % (chromosome, base_start_pos))

                        wig_file.write("%i\n" % (base_score[nucl]))


    for key, value in sizes.items():
        chr_sizes.write("%s\t%i\n"%(key, value))

    fp.close()
    wig_file.close()
    chr_sizes.close()

    print "Converting wig to bigwig"
    cl = ["wigToBigWig", wig_filename, chr_sizes_filename, bigwig_filename]
    subprocess.check_call(cl)

    # remove temp files
    if not keep_tempfile:
        os.remove(chr_sizes_filename)
        os.remove(wig_filename)

    print "Done."

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option('-o', '--bigwig_filename', dest='bigwig_filename')
    parser.add_option('-t', '--tempfile', dest='use_tempfile',
                      action='store_true', default=False)
    parser.add_option('-k', '--keeptemp', dest='keep_tempfile',
                      action='store_true', default=False)
    parser.add_option('-g', '--gzip', dest='use_gzip',
                      action='store_true', default=False)
    (options, args) = parser.parse_args()
    if len(args) == 0:
        print __doc__
        sys.exit()
    else:
        try:
            p = subprocess.Popen(["wigToBigWig"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except OSError:
            print "Please check your wigToBigWig is in $PATH"
            sys.exit()
        except subprocess.CalledProcessError:  # exit status 255 is expected
            pass
        kwargs = dict(
            bigwig_filename=options.bigwig_filename,
            use_tempfile=options.use_tempfile,
            keep_tempfile=options.keep_tempfile,
            use_gzip=options.use_gzip)
        for fasta_filename in args:
            main(fasta_filename, **kwargs)
