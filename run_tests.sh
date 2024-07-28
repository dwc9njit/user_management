#!/bin/bash

# Ensure the coverage_report directory exists and has the right permissions
mkdir -p $GITHUB_WORKSPACE/coverage_report && chmod -R 777 $GITHUB_WORKSPACE/coverage_report

# Run the tests with coverage
docker-compose exec fastapi pytest --cov=app --cov-report=xml:/tmp/coverage_report/coverage.xml --cov-report=html:/tmp/coverage_report/html --cov-report=term-missing

# Ensure the coverage report directory exists and has the correct permissions
mkdir -p ~/IS601/final_project/user_management/coverage_report
chmod -R 777 ~/IS601/final_project/user_management/coverage_report

# Copy the coverage reports to the host machine
docker cp user_management-fastapi-1:/tmp/coverage_report/html ~/IS601/final_project/user_management/coverage_report/html
docker cp user_management-fastapi-1:/tmp/coverage_report/coverage.xml ~/IS601/final_project/user_management/coverage_report/coverage.xml

# Print a message indicating where the reports can be found
echo "Coverage reports have been copied to ~/IS601/final_project/user_management/coverage_report/"

# Optionally open the HTML report in a web browser (uncomment the line below if desired)

xdg-open ~/IS601/final_project/user_management/coverage_report/html/index.html &

# Display the HTML report using a simple HTTP server (for terminal viewing)
python -m http.server --directory ~/IS601/final_project/user_management/coverage_report/html 8000 &

