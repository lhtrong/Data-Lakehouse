## Introduction
As the world of data management continues to evolve, organizations are constantly seeking new technologies
and approaches to help them unlock the full potential of their data. One such approach is the data lakehouse,
a pattern that combines features of both data warehouses and data lakes to create a unified data platform.


![Architecture](/Images/DemoArchitecture/png "Architecture")


## Set up

Create docker images:
```bash
docker build -t presto:0.272.1 ./Dockerfiles/presto
docker build -t cluster-apache-spark:3.1.1 Dockerfiles/spark
```
Docker compose:
```bash
docker-compose up
```

Install dependencies:

```bash 
docker exec -it master bash /opt/workspace/dependencies/packages_installer.sh 
```

## Run 
1. Create a bucket named "datalake" in Minio (localhost:9001)

2. Create "CarParts" database in Postgres (using CarParts.sql in sql folder)


3. Extract data from Postgres and ingest to Minio
```bash
docker exec -it master spark-submit --jars /opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar,/opt/spark/jars/hadoop-aws-3.2.0.jar,/opt/spark/jars/postgresql-42.3.5.jar \
        --master spark://master:7077 \
        --deploy-mode client \
        --packages io.delta:delta-core_2.12:1.0.1 \
        --conf "spark.executor.extraClassPath=/opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar:/opt/spark/jars/hadoop-aws-3.2.0.jar:/opt/spark/jars/postgresql-42.3.5.jar" \
        --conf "spark.driver.extraClassPath=/opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar:/opt/spark/jars/hadoop-aws-3.2.0.jar:/opt/spark/jars/postgresql-42.3.5.jar" \
        /opt/workspace/postgres_to_s3.py
```
4. Transform data in Minio
```bash
docker exec -it master spark-submit --jars /opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar,/opt/spark/jars/hadoop-aws-3.2.0.jar,/opt/spark/jars/postgresql-42.3.5.jar \
        --master spark://master:7077 \
        --deploy-mode client \
        --packages io.delta:delta-core_2.12:1.0.1 \
        --conf "spark.executor.extraClassPath=/opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar:/opt/spark/jars/hadoop-aws-3.2.0.jar:/opt/spark/jars/postgresql-42.3.5.jar" \
        --conf "spark.driver.extraClassPath=/opt/spark/jars/aws-java-sdk-bundle-1.11.375.jar:/opt/spark/jars/hadoop-aws-3.2.0.jar:/opt/spark/jars/postgresql-42.3.5.jar" \
        /opt/workspace/clean_data.py
```

5. Create external table in Presto to query data in Minio 

6. Connect to Metabase to using BI

![Connec to Metabase](/Images/DemoArchitecture/png "Connect to Metabase")

