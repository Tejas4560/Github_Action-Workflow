# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Add metadata labels
LABEL maintainer="your-email@example.com"
LABEL description="Simple Flask application for learning GitHub Actions CI/CD"
LABEL version="1.0"

# Set the working directory
WORKDIR /app

# Copy requirements first for better layer caching
# This means dependencies won't reinstall if only code changes
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]