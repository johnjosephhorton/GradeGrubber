GradeGrubber
============

This an R package to create student-specific statistical feedback on
their course performance. It depends on two files: 
- An assignments CSV file, which is a list of each assignment (with a
  unique name) and the number of points it was worth
- A grades CSV file, which has the list of students and what they
  earned on each assignment. 

To use run: 

	library(GradeGrubber) 
	createReport(<path.to.assignment.file>, <path.to.grades.file>, <path.to.report.directory>) 





