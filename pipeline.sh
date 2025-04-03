#Explanation

1. FastQC checks the raw reads.

2. Cutadapt trims adapters.

3. STAR aligns reads to a reference genome.

4. featureCounts quantifies reads mapping to genes (for a typical bulk RNA-seq approach).

---

### **pipeline.sh** (Shell Script Example)

```bash
#!/usr/bin/env bash
#
# pipeline.sh
# A toy RNA-seq / snRNA-seq pipeline demonstrating typical steps for QC, trimming, alignment, etc.

# 0) Define paths and parameters
FASTQ1="path/to/sample_R1.fastq.gz"
FASTQ2="path/to/sample_R2.fastq.gz"   # Omit if single-end
GENOME_REFERENCE="path/to/genome_index"   # e.g. STAR index directory
GTF="path/to/annotation.gtf"
THREADS=8

# 1) Quality Control (FastQC)
echo "Running FastQC..."
fastqc -t ${THREADS} ${FASTQ1} ${FASTQ2} -o qc_reports/

# 2) Trimming (Cutadapt or any other tool)
echo "Trimming adapters with Cutadapt..."
cutadapt -j ${THREADS} \
  -a AGATCGGAAGAGC -A AGATCGGAAGAGC \   # Example Illumina adapter
  -o trimmed_R1.fastq.gz \
  -p trimmed_R2.fastq.gz \
  ${FASTQ1} ${FASTQ2}

# 3) Alignment (e.g. using STAR)
echo "Aligning reads with STAR..."
STAR --runThreadN ${THREADS} \
     --genomeDir ${GENOME_REFERENCE} \
     --readFilesIn trimmed_R1.fastq.gz trimmed_R2.fastq.gz \
     --readFilesCommand zcat \
     --outFileNamePrefix star_output/ \
     --outSAMtype BAM SortedByCoordinate

# 4) Counting (e.g. FeatureCounts for bulk or Excerpt, Cell Ranger for single-cell, etc.)
# Here's a toy example with featureCounts for illustrative purposes
echo "Counting reads with featureCounts..."
featureCounts -T ${THREADS} \
  -a ${GTF} \
  -o counts.txt \
  star_output/Aligned.sortedByCoord.out.bam

echo "All steps completed. Check your 'qc_reports/' folder, 'star_output/' directory, and 'counts.txt' for results."
