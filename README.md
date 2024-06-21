# AWS-Serverless-Web-App (Serverless Web Application with AWS)

This repository contains a serverless web application that performs CRUD operations on a DynamoDB table using AWS Lambda and API Gateway, simulated locally with LocalStack.

## Features

- Create, Read, Update, Delete (CRUD) operations
- Serverless architecture using AWS Lambda and API Gateway
- DynamoDB for data storage
- Local simulation of AWS services using LocalStack

## Prerequisites

- Docker and Docker Compose
- AWS CLI
- Python 3.x
- Boto3
- awscli-local (`awslocal`)

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/megamiii/AWS-Serverless-Web-App.git
cd AWS-Serverless-Web-App
```

### 2. Install Dependencies for Backend

```bash
pip install -r backend/requirements.txt
```

### 3. Start LocalStack Using Docker Compose
Navigate to the `localstack` directory and start LocalStack:
```bash
cd localstack
docker-compose up
```

### 4. Deploy the Lambda Functions to LocalStack
Run the `localstack_setup.sh` script:
```bash
chmod +x localstack_setup.sh
./localstack_setup.sh
```

This script will:
- Create the WebAppItems DynamoDB table.
- Create and deploy the createItem, readItem, updateItem, and deleteItem Lambda functions.
- Set up API Gateway to route HTTP requests to the Lambda functions.
- Deploy the API Gateway.

### 5. Update Frontend API URL
After running the setup script, note the `API_ID` output and update the `apiUrl` in `frontend/script.js` with this actual `API_ID`.

```javascript
const apiUrl = 'http://localhost:4566/restapis/YOUR_API_ID/local/_user_request_';
```

### 6. Use the Frontend to Interact with the Backend
Open `frontend/index.html` in a web browser and use the buttons to perform CRUD operations.

## Project Structure
```
AWS-Serverless-Web-App/
│
├── README.md
├── .gitignore
├── backend/
│   ├── create_item.py
│   ├── read_item.py
│   ├── update_item.py
│   ├── delete_item.py
│   ├── requirements.txt
│   └── event.json
├── frontend/
│   ├── index.html
│   ├── script.js
│   └── style.css
└── localstack/
    ├── docker-compose.yml
    └── localstack_setup.sh
```

### Backend
- `create_item.py`: Lambda function to create an item in DynamoDB.
- `read_item.py`: Lambda function to read an item from DynamoDB.
- `update_item.py`: Lambda function to update an item in DynamoDB.
- `delete_item.py`: Lambda function to delete an item from DynamoDB.
- `requirements.txt`: Python dependencies for the backend.
- `event.json`: Example event data for testing Lambda functions.

### Frontend
- `index.html`: Simple HTML file with buttons to perform CRUD operations.
- `script.js`: JavaScript to handle button clicks and make API requests.
- `style.css`: Basic styling for the HTML page.

### LocalStack
- `docker-compose.yml`: Configuration file to set up LocalStack with Docker Compose.
- `localstack_setup.sh`: Script to create DynamoDB table, deploy Lambda functions, and set up API Gateway.

## Usage Examples
### Create an Item
1. Open the frontend (index.html) in a web browser.
2. Click the "Create Item" button.
3. Check the console log for the result.

### Read an Item
1. Open the frontend (index.html) in a web browser.
2. Click the "Read Item" button.
3. Check the console log for the result.

### Update an Item
1. Open the frontend (index.html) in a web browser.
2. Click the "Update Item" button.
3. Check the console log for the result.

### Delete an Item
1. Open the frontend (index.html) in a web browser.
2. Click the "Delete Item" button.
3. Check the console log for the result.