#!/usr/bin/env python
"""
aws_s3_utils.py
Simple utilities for uploading/downloading files to AWS S3.

Usage:
  python aws_s3_utils.py upload local_folder/ s3://mybucket/somepath/
  python aws_s3_utils.py download s3://mybucket/somepath/ local_folder/
"""

import sys
import subprocess

def aws_s3_upload(local_path, s3_path):
    # Using AWS CLI via subprocess
    cmd = ["aws", "s3", "cp", local_path, s3_path, "--recursive"]
    print(f"Uploading from {local_path} to {s3_path}...")
    subprocess.run(cmd, check=True)

def aws_s3_download(s3_path, local_path):
    cmd = ["aws", "s3", "cp", s3_path, local_path, "--recursive"]
    print(f"Downloading from {s3_path} to {local_path}...")
    subprocess.run(cmd, check=True)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage:")
        print("  python aws_s3_utils.py upload <local_path> <s3_path>")
        print("  python aws_s3_utils.py download <s3_path> <local_path>")
        sys.exit(1)

    action = sys.argv[1]
    path1 = sys.argv[2]
    path2 = sys.argv[3]

    if action == "upload":
        aws_s3_upload(path1, path2)
    elif action == "download":
        aws_s3_download(path1, path2)
    else:
        print("Action must be 'upload' or 'download'.")
        sys.exit(1)
