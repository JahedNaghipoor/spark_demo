from datetime import datetime, date
import pandas as pd
from pyspark.sql import Row
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

df = spark.read.csv('Rep_vs_Dem_tweets.csv',inferSchema=True,header=True)

print(df.toPandas())