# HDFS - File System (FS) Shell

#### Basic Guide to commands and administration in HDFS.

**Listing Files** using <code>hadoop</code> and <code>hdfs</code>:

	$ hadoop fs -ls /user/cloudera/input

	$ hdfs dfs -ls /user/cloudera/input

These commands return the same result. <code>hadoop</code> and <code>hdfs</code> are two different scripts but when you say: *hadoop fs* the hadoop script finds the hdfs script and runs *hdfs dfs*.












