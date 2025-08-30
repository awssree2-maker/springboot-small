import boto3
import pandas as pd
import numpy as pd
import io

s3 = boto3.client("s3")

def lambda_handler(event, context):
    for record in event["Records"]:
        bucket = record["s3"]["bucket"]["name"]
        key = record["s3"]["object"]["key"]

        if not key.startswith("input/") or not key.endswith(".csv"):
            print(f"Skipping {key}")
            continue

        print(f"Processing file: s3://{bucket}/{key}")

        response = s3.get_object(Bucket=bucket, Key=key)
        csv_data = response["Body"].read().decode("utf-8")
        df = pd.read_csv(io.StringIO(csv_data))

        parquet_buffer = io.BytesIO()
        df.to_parquet(parquet_buffer, index=False)

        output_key = key.replace("input/", "output/").replace(".csv", ".parquet")
        s3.put_object(Bucket=bucket, Key=output_key, Body=parquet_buffer.getvalue())
        print(f"Written parquet to s3://{bucket}/{output_key}")
