import psycopg2
import json
import boto3

def get_secret(secret_name):
    # Create a Secrets Manager client
    client = boto3.client('secretsmanager')

    # Retrieve the secret
    response = client.get_secret_value(SecretId=secret_name)
    secret_string = response['SecretString']
    
    return json.loads(secret_string)

def lambda_handler(event, context):
    # Retrieve database credentials from AWS Secrets Manager
    secret_name = "your-secret-name"
    db_credentials = get_secret(secret_name)

    try:
        # Create a connection to the PostgreSQL database
        connection = psycopg2.connect(
            host=db_credentials['host'],
            user=db_credentials['username'],
            password=db_credentials['password'],
            database=db_credentials['database']
        )

        cursor = connection.cursor()
        cursor.execute('SELECT * FROM Transactions')
        rows = cursor.fetchall()

        for row in rows:
            print(f"{row[0]} {row[1]} {row[2]}")

        cursor.close()
        connection.close()

    except Exception as e:
        print(f"Error: {str(e)}")