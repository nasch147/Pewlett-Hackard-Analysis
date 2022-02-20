-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) employees.emp_no,
						employees.first_name,
						employees.last_name,
						titles.title, 
						titles.from_date, 
						titles.to_date
INTO retire_by_title
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no ASC;

-- Create Unique Retirement title table
SELECT DISTINCT ON (emp_no) retire_by_title.emp_no,
							retire_by_title.first_name,
							retire_by_title.last_name,
							retire_by_title.title
INTO uniq_retire_by_title
FROM retire_by_title
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

--Create count of retirees by department
SELECT count (uniq_retire_by_title.title), title
INTO retiring_titles_final
FROM uniq_retire_by_title
GROUP BY uniq_retire_by_title.title
ORDER BY uniq_retire_by_title.count DESC;

--Deliverable 2
SELECT DISTINCT ON (emp_no) employees.emp_no, 
		employees.first_name,
		employees.last_name,
		employees.birth_date,
		department_ee.from_date,
		department_ee.to_date,
		titles.title
INTO mentorship
FROM employees
	JOIN department_ee
		ON employees.emp_no = department_ee.emp_no
	JOIN titles
		ON employees.emp_no = titles.emp_no
WHERE (department_ee.to_date = '9999-01-01')
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no ASC;