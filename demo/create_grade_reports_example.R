library(GradeGrubber)

assignments.file <- "demo_assignments.csv"
grades.file <- "demo_grades.csv"

report.dir <- "./reports" 

createReport(assignments.file, grades.file, report.dir)
