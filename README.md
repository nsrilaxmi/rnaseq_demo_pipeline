# rnaseq_demo_pipeline
Example RNA-seq pipeline for demonstration purposes

# RNA-seq / snRNA-seq Demonstration Pipeline

This repository showcases a **toy pipeline** for RNA-seq or single-nuclei RNA-seq data analysis using common tools. It includes:

1. `pipeline.sh`: A shell script demonstrating basic QC, trimming, alignment, and counting.
2. `aws_s3_utils.py`: A Python script for simple AWS S3 uploads and downloads.

**Note:** This pipeline is for demonstration only. In a real workflow:
- You'll customize paths, file names, and parameters.
- You may add steps for advanced single-cell analysis (e.g., Cell Ranger, Seurat-based downstream steps).
- Ensure you have tools like Cutadapt, STAR, FastQC, etc. installed and in your `$PATH`.
- AWS credentials must be configured properly for `aws_s3_utils.py`.

## Quick Start
1. Update `pipeline.sh` with your **FASTQ** files, **GENOME_REFERENCE**, **GTF**, etc.
2. Make the script executable:  
   ```bash
   chmod +x pipeline.sh

3. Run the pipeline:
  ./pipeline.sh
4. Use aws_s3_utils.py if you need to upload final results to S3:
   python aws_s3_utils.py upload results/ s3://mybucket/results/
