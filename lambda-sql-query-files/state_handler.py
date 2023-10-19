import psycopg2
 
# 1. Install psycopg2 to local directory
# pip install -t $PWD psycopg2
 

# Lambda Permissions:
# AWSLambdaVPCAccessExecutionRole
#AmazonMQFullAccess and Inline Policy for Secret Manager.
 
#Configuration Values

endpoint = 'yourendpoint.com'
username = 'your username'
password = 'your password'
database_name = 'your database name'
 
#Connection
connection = psycopg2.connect(endpoint, user=username,
	passwd=password, db=database_name)
 
def lambda_handler(event, context):
	cursor = connection.cursor()
	cursor.execute('SELECT * from Transactions')
 
	rows = cursor.fetchall()
 
	for row in rows:
		print("{0} {1} {2}".format(row[0], row[1], row[2]))