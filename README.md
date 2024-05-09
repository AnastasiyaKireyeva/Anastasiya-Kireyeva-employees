# Employee Project Collaboration Calculator

This application calculates the pair of employees who worked together on projects for the longest total amount of time. It reads data from a CSV file and outputs the employee pair, the total days they worked together, and the projects they collaborated on.

## Installation

To install the application, follow these steps:

1. Clone the repository:
   ```
   git clone git@github.com:AnastasiyaKireyeva/Anastasiya-Kireyeva-employees.git
   ```
2. Navigate to the application directory:
   ```
   cd Anastasiya-Kireyeva-employees
   ```
3. Install the required Ruby gems:
   ```
   bundle install
   ```

## Usage

To use the application, you need to have a CSV file that contains the employee data. The CSV file should have the following columns: `EmpID`, `ProjectID`, `DateFrom`, `DateTo`.

You can run the application with the following command:

```
ruby app/main.rb
```

The application will output the pair of employees who worked together the longest, the total days they worked together, and the projects they worked on.

## Testing

You can run the tests for the application with the following command:

```
rspec
```
