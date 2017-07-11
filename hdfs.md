# HDFS - File System (FS) Shell

#### Basic Guide to commands and administration in HDFS.

**Listing Files** using <code>hadoop</code> and <code>hdfs</code>:

	$ hadoop fs -ls /user/cloudera
	$ hdfs dfs -ls /user/cloudera

These commands return the same result. <code>hadoop</code> and <code>hdfs</code> are two different scripts but when you say: *hadoop fs* the hadoop script finds the hdfs script and runs *hdfs dfs*.

**Create a few simple text files**

	$ echo "A long time ago in a galaxy far, far away" > /home/cloudera/testfile1
	$ echo "May the force be with you" > /home/cloudera/textfile2

**Create a directory on HDFS**

	$ hdfs dfs -mkdir /user/cloudera/input

**Copy the files from local machine to HDFS**

	$ hdfs dfs -put /home/cloudera/testfile1 /user/cloudera/input
	$ hdfs dfs -put /home/cloudera/testfile2 /user/cloudera/input

**Inspect the files in HDFS**

	$ hdfs dfs -ls /user/cloudera/input

**Copy the files from HDFS to local machine**

	$ hdfs dfs -get /user/cloudera/input/outputfile1 /home/cloudera
	$ hdfs dfs -get /user/cloudera/input/outputfile2 /home/cloudera
 
#### Additional Commands

**cat**

	$ hdfs dfs -cat /user/cloudera/input/outputfile1

**chmod**

	$ hdfs dfs -chmod +x /home/cloudera/wordcount_mapper.py

**chown**

	$ hdfs dfs -chown

**copyFromLocal** - similar to put command, except the source is restricted to a local file reference

	$ hdfs dfs -copyFromLocal

**copyToLocal** - similar to get command, except the destination is restricted to a local file reference

	$ hdfs dfs -copyToLocal

**count**

	$ hdfs dfs -count

**cp**
	
	$ hdfs dfs -cp

**du**

	$ hdfs dfs -du

**get**

	$ hdfs dfs -get /user/cloudera/input/outputfile1 /home/cloudera

**ls**

	$ hdfs dfs -ls

**lsr**

	$ hdfs dfs -lsr

**mkdir**

	$ hdfs dfs -mkdir

**moveFromLocal** - similar to put command, except the source is deleted after it is copied

	$ hdfs dfs -moveFromLocal

**mv**

	$ hdfs dfs -mv

**put**

	$ hdfs dfs -put /home/cloudera/testfile1 /user/cloudera/input

**rm**

	$ hdfs dfs -rm

**rmr**

	$ hdfs dfs -rmr

**stat**

	$ hdfs dfs -stat

**tail**

	$ hdfs dfs -tail

**test**

	$ hdfs dfs -test

**text**

	$ hdfs dfs -text

**touchz**

	$ hdfs dfs -touchz














