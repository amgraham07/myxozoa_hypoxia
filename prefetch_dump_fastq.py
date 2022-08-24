import subprocess

# samples correspond to SRAs you want to fetch
sra_numbers = ["SRR_lib1",
"SRR_lib2",
"SRR_lib3"]

# this will download the .sra files to ~/ncbi/public/sra/ (will create directory if not present)
for sra_id in sra_numbers:
    print ("Currently downloading: " + sra_id)
    prefetch = "prefetch " + sra_id
    print ("The command used was: " + prefetch)
    subprocess.call(prefetch, shell=True)

# this will extract the .sra files from above into a folder named 'fastq'
for sra_id in sra_numbers:
    print ("Generating fastq for: " + sra_id)
    fasterq_dump = "fasterq-dump --outdir fastq " + sra_id + "/" + sra_id + ".sra"
    print ("The command used was: " + fasterq_dump)
    subprocess.call(fasterq_dump, shell=True)