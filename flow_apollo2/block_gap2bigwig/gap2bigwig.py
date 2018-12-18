#!/usr/bin/env python
import os
import sys
import subprocess
import tempfile
import re
from optparse import OptionParser
from contextlib import contextmanager

'''
Version: 1.12

Find out gap regions (i.e., N base) from a FASTA file and convert to a BigWig file format.

Usage:
    gap2bigwig.py <FASTA file>
    [-o, --bigwig_filename=<output file name>
     -t, --tempfile
     -k, --keep_tempfile
     -g, --gzip]

Prerequisites:
  ucsc_bigwig: wigToBigWig can be downloaded from UCSC Genome Browser (http://hgdownload.cse.ucsc.edu/admin/exe/)

(c) Chien-Yueh Lee 2014-2015 / MIT Licence
kinomoto[AT]sakura[DOT]idv[DOT]tw
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

    N_start_pos = 0
    N_len = 0
    chromosome = 'My_sequence'
    counter = 0
    sizes = dict()
    
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
                    print "Processing %s" % m[0]
                else:
                    print "No chromosome match!"
                    sys.exit(1)
            else:   # in seq.
                for nucl in line:
                    counter += 1
                    if nucl.upper() == "N":  # hit N
                        if N_len == 0:
                            N_start_pos = counter
                        N_len += 1
                    elif N_len > 0:  # N fishined (i.e., hit other nucleotides)
                        wig_file.write("fixedStep chrom=%s start=%i step=1 span=%i\n1\n" % (chromosome, N_start_pos, N_len))
                        N_len = 0
                        N_start_pos = 0

                    sizes[chromosome] = counter  # count chromosome size

    for key, value in sizes.items():
        chr_sizes.write("%s\t%i\n" % (key, value))

    fp.close()
    wig_file.close()
    chr_sizes.close()

    cl = ["wigToBigWig", wig_filename, chr_sizes_filename, bigwig_filename]
    subprocess.check_call(cl)

    # remove temp files
    if not keep_tempfile:
        os.remove(chr_sizes_filename)
        os.remove(wig_filename)


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
        except subprocess.CalledProcessError:
            pass
        kwargs = dict(
            bigwig_filename=options.bigwig_filename,
            use_tempfile=options.use_tempfile,
            keep_tempfile=options.keep_tempfile,
            use_gzip=options.use_gzip)
        for fasta_filename in args:
            main(fasta_filename, **kwargs)
