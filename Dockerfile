FROM mambaorg/micromamba:2.3.0

# ==========================================================================
# System packages
# ==========================================================================

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        wget \
        build-essential \
        perl \
        nodejs \
        npm \
        rsync \
        openssh-client \
        gzip \
        coreutils \
        grep \
        findutils \
        sed \
        gawk \
        tar \
        unzip \
        zip \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*


# ==========================================================================
# Directories
# ==========================================================================

RUN mkdir -p \
        /opt \
        /pipeline \
        /app/data \
        /work-dir \
    && chown -R $MAMBA_USER:$MAMBA_USER \
        /opt \
        /pipeline \
        /app \
        /work-dir


# ==========================================================================
# Conda environment
# ==========================================================================

USER $MAMBA_USER

RUN micromamba create -y -n onboarding -c conda-forge -c bioconda \
        python=3.11 pip \
        "perl=5.32.1" "jbrowse=1.16.1" \
        "conda-forge::perl-db_file=1.858" "libdb=6.2.32" \
        "samtools=0.1.19" "wiggletools=1.2.1" \
        htslib bedtools pysam rsem pybigwig ucsc-wigtobigwig ucsc-fatotwobit \
    && micromamba clean --all --yes \
 && /opt/conda/envs/onboarding/bin/perl -MDB_File -e 'print "DB_File OK\n"'


# ==========================================================================
# PATH
# ==========================================================================

ENV PATH="/opt/content_onboarding_scripts/bin:/opt/conda/envs/onboarding/bin:${PATH}"


# ==========================================================================
# Python / CWL
# ==========================================================================

RUN pip install --no-cache-dir \
        cwltool \
        cwlref-runner


# ==========================================================================
# Clone repositories
# ==========================================================================

WORKDIR /opt

RUN git clone \
        --branch update-functional-annotation \
        --single-branch \
        https://github.com/NAL-i5K/Organism_Onboarding.git \
        Organism_Onboarding

RUN git clone --depth 1 \
        https://github.com/NAL-i5K/content_onboarding_scripts.git \
        content_onboarding_scripts

RUN git clone --depth 1 \
        https://github.com/NAL-i5K/wiggle-tools.git \
        wiggle-tools

RUN git clone --depth 1 \
        https://github.com/NAL-i5K/bam_to_bigwig.git \
        bam_to_bigwig

RUN git clone --depth 1 \
        https://github.com/NAL-i5K/ColorByType.git \
        ColorByType


# ==========================================================================
# Environment variables
# ==========================================================================

ENV ORGANISM_ONBOARDING=/opt/Organism_Onboarding
ENV WIGGLE_TOOLS=/opt/wiggle-tools
ENV BAM_TO_BIGWIG=/opt/bam_to_bigwig
ENV COLORBYTYPE=/opt/ColorByType
ENV CONTENT_ONBOARDING_SCRIPTS=/opt/content_onboarding_scripts


# ==========================================================================
# Make repository scripts executable
# ==========================================================================

USER root

RUN find /opt/content_onboarding_scripts \
        -type f \
        \( -name '*.pl' -o -name '*.py' \) \
        -exec chmod +x {} \; \
        2>/dev/null || true

RUN find /opt/bam_to_bigwig \
        -type f \
        -name '*.py' \
        -exec chmod +x {} \; \
        2>/dev/null || true

RUN find /opt/ColorByType \
        -type f \
        -exec chmod +x {} \; \
        2>/dev/null || true


# ==========================================================================
# Install bam_to_bigwig.py
# ==========================================================================

RUN if [ -f /opt/bam_to_bigwig/bam_to_bigwig.py ]; then \
        cp /opt/bam_to_bigwig/bam_to_bigwig.py \
           /usr/local/bin/bam_to_bigwig.py; \
        chmod +x /usr/local/bin/bam_to_bigwig.py; \
    fi


# ==========================================================================
# Search for pipeline-specific executables
# ==========================================================================

RUN echo "========================================" \
    && echo "SEARCHING FOR PIPELINE SCRIPTS" \
    && echo "========================================" \
    && find /opt \
        -type f \
        \( \
            -name 'GCcontent2bigwig.py' \
            -o -name 'gap2bigwig.py' \
            -o -name 'generate-names.pl' \
            -o -name 'add_metadata_to_GC_gap_bigwig_tracks.pl' \
            -o -name 'add-bw-track.pl' \
            -o -name 'prepare-refseqs.pl' \
            -o -name 'add_NCBI_annotation_track.py' \
            -o -name 'createOrganism.py' \
            -o -name 'fasta_diff' \
            -o -name 'gff3_QC' \
            -o -name 'add_ontology_terms_from_gaf_gmt.pl' \
        \) \
        -print | sort


# ==========================================================================
# Install GCcontent2bigwig.py
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'GCcontent2bigwig.py' \
        -exec cp {} /usr/local/bin/GCcontent2bigwig.py \; \
        -exec chmod +x /usr/local/bin/GCcontent2bigwig.py \;


# ==========================================================================
# Install gap2bigwig.py
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'gap2bigwig.py' \
        -exec cp {} /usr/local/bin/gap2bigwig.py \; \
        -exec chmod +x /usr/local/bin/gap2bigwig.py \;


# ==========================================================================
# Install generate-names.pl
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'generate-names.pl' \
        -exec cp {} /usr/local/bin/generate-names.pl \; \
        -exec chmod +x /usr/local/bin/generate-names.pl \;


# ==========================================================================
# Install add_metadata_to_GC_gap_bigwig_tracks.pl
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'add_metadata_to_GC_gap_bigwig_tracks.pl' \
        -exec cp {} /usr/local/bin/add_metadata_to_GC_gap_bigwig_tracks.pl \; \
        -exec chmod +x /usr/local/bin/add_metadata_to_GC_gap_bigwig_tracks.pl \;


# ==========================================================================
# Install add-bw-track.pl
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'add-bw-track.pl' \
        -exec cp {} /usr/local/bin/add-bw-track.pl \; \
        -exec chmod +x /usr/local/bin/add-bw-track.pl \;


# ==========================================================================
# Install prepare-refseqs.pl
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'prepare-refseqs.pl' \
        -exec cp {} /usr/local/bin/prepare-refseqs.pl \; \
        -exec chmod +x /usr/local/bin/prepare-refseqs.pl \;


# ==========================================================================
# Install add_NCBI_annotation_track.py
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'add_NCBI_annotation_track.py' \
        -exec cp {} /usr/local/bin/add_NCBI_annotation_track.py \; \
        -exec chmod +x /usr/local/bin/add_NCBI_annotation_track.py \;


# ==========================================================================
# Install createOrganism.py
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'createOrganism.py' \
        -exec cp {} /usr/local/bin/createOrganism.py \; \
        -exec chmod +x /usr/local/bin/createOrganism.py \;


# ==========================================================================
# Install fasta_diff
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'fasta_diff' \
        -exec cp {} /usr/local/bin/fasta_diff \; \
        -exec chmod +x /usr/local/bin/fasta_diff \;


# ==========================================================================
# Install gff3_QC
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'gff3_QC' \
        -exec cp {} /usr/local/bin/gff3_QC \; \
        -exec chmod +x {} \;


# ==========================================================================
# Install ontology annotation script
# ==========================================================================

RUN find /opt \
        -type f \
        -name 'add_ontology_terms_from_gaf_gmt.pl' \
        -exec cp {} /usr/local/bin/add_ontology_terms_from_gaf_gmt.pl \; \
        -exec chmod +x /usr/local/bin/add_ontology_terms_from_gaf_gmt.pl \;


# ==========================================================================
# Copy complete Organism_Onboarding repository to /pipeline
# ==========================================================================

RUN cp -a \
        /opt/Organism_Onboarding/. \
        /pipeline/


# ==========================================================================
# Verify final workflow
# ==========================================================================

RUN echo "========================================" \
    && echo "REQUIRED WORKFLOW" \
    && echo "========================================" \
    && test -f /pipeline/final-workflow.cwl \
    && ls -lh /pipeline/final-workflow.cwl


# ==========================================================================
# Node.js
# ==========================================================================

RUN echo "========================================" \
    && echo "NODE.JS" \
    && echo "========================================" \
    && command -v node \
    && node --version \
    && node -e "console.log('Node.js JavaScript evaluation works')"


# ==========================================================================
# Python
# ==========================================================================

RUN echo "========================================" \
    && echo "PYTHON" \
    && echo "========================================" \
    && python --version


# ==========================================================================
# CWL
# ==========================================================================

RUN echo "========================================" \
    && echo "CWLTOOL" \
    && echo "========================================" \
    && cwltool --version

RUN echo "========================================" \
    && echo "CWL RUNNER" \
    && echo "========================================" \
    && command -v cwl-runner \
    && cwl-runner --version


# ==========================================================================
# SAMTOOLS
#
# Do not use "samtools --version"; this build of samtools does not support it.
# ==========================================================================

RUN echo "========================================" \
    && echo "SAMTOOLS" \
    && echo "========================================" \
    && command -v samtools \
    && samtools 2>&1 | head -5 || true


# ==========================================================================
# WIGTOBIGWIG
# ==========================================================================

RUN echo "========================================" \
    && echo "WIGTOBIGWIG" \
    && echo "========================================" \
    && command -v wigToBigWig \
    && wigToBigWig 2>&1 | head -5 || true


# ==========================================================================
# FATOTWOBIT
# ==========================================================================

RUN echo "========================================" \
    && echo "FATOTWOBIT" \
    && echo "========================================" \
    && command -v faToTwoBit \
    && faToTwoBit 2>&1 | head -5 || true


# ==========================================================================
# PYSAM
# ==========================================================================

RUN echo "========================================" \
    && echo "PYSAM" \
    && echo "========================================" \
    && python -c "import pysam; print('pysam', pysam.__version__)"


# ==========================================================================
# PYBIGWIG
# ==========================================================================

RUN echo "========================================" \
    && echo "PYBIGWIG" \
    && echo "========================================" \
    && python -c "import pyBigWig; print('pyBigWig', pyBigWig.__version__)"


# ==========================================================================
# Validate pipeline-specific executables
# ==========================================================================

RUN echo "========================================" \
    && echo "PIPELINE EXECUTABLES" \
    && echo "========================================" \
    && command -v GCcontent2bigwig.py || true \
    && command -v gap2bigwig.py || true \
    && command -v generate-names.pl || true \
    && command -v add_metadata_to_GC_gap_bigwig_tracks.pl || true \
    && command -v add-bw-track.pl || true \
    && command -v prepare-refseqs.pl || true \
    && command -v add_NCBI_annotation_track.py || true \
    && command -v createOrganism.py || true \
    && command -v fasta_diff || true \
    && command -v gff3_QC || true \
    && command -v add_ontology_terms_from_gaf_gmt.pl || true \
    && command -v bam_to_bigwig.py || true


# ==========================================================================
# Validate standard commands
# ==========================================================================

RUN echo "========================================" \
    && echo "STANDARD COMMANDS" \
    && echo "========================================" \
    && command -v bash \
    && command -v cat \
    && command -v cp \
    && command -v egrep \
    && command -v find \
    && command -v grep \
    && command -v gzip \
    && command -v ln \
    && command -v md5sum \
    && command -v mkdir \
    && command -v perl \
    && command -v python \
    && command -v rsync \
    && command -v scp \
    && command -v ssh \
    && command -v touch \
    && command -v wget


# ==========================================================================
# Validate repositories
# ==========================================================================

RUN echo "========================================" \
    && echo "REPOSITORIES" \
    && echo "========================================" \
    && test -d /opt/Organism_Onboarding \
    && test -d /opt/content_onboarding_scripts \
    && test -d /opt/wiggle-tools \
    && test -d /opt/bam_to_bigwig \
    && test -d /opt/ColorByType \
    && echo "All repositories present"


# ==========================================================================
# Display installed pipeline scripts
# ==========================================================================

RUN echo "========================================" \
    && echo "INSTALLED PIPELINE SCRIPTS" \
    && echo "========================================" \
    && find /usr/local/bin \
        -maxdepth 1 \
        -type f \
        \( \
            -name 'GCcontent2bigwig.py' \
            -o -name 'gap2bigwig.py' \
            -o -name 'generate-names.pl' \
            -o -name 'add_metadata_to_GC_gap_bigwig_tracks.pl' \
            -o -name 'add-bw-track.pl' \
            -o -name 'prepare-refseqs.pl' \
            -o -name 'add_NCBI_annotation_track.py' \
            -o -name 'createOrganism.py' \
            -o -name 'fasta_diff' \
            -o -name 'gff3_QC' \
            -o -name 'add_ontology_terms_from_gaf_gmt.pl' \
            -o -name 'bam_to_bigwig.py' \
        \) \
        -print | sort


# ==========================================================================
# Working directory
# ==========================================================================

USER $MAMBA_USER

WORKDIR /work

CMD ["/bin/bash"]
