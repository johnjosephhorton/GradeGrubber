#' #' Creates a report based on an assignments file (CSV) and a grade file (CSV). 
#'
#' @param assignments.file - the assignments
#' @param grades.file - the grades 
#' @param report.directory - location to put the reports 
#' @return  None - run for side-effects (writes individual PDF sheets).  
#' @export 

createReport <- function(assignments.file, grades.file, report.directory){   
    df.assignments <- read.csv(assignments.file, stringsAsFactors = FALSE)
    df.grades <- read.csv(grades.file, stringsAsFactors = FALSE)
    students <- as.character(df.grades[, 1])
    assignments <- as.character(df.assignments[, 1])
    header.file <- system.file("header.tex", package="GradeGrubber")
    header <- readLines(header.file)
    for(student in students){
        df.grades.indiv <- subset(df.grades, Student.Name == student)
        df.tmp <- melt(df.grades.indiv, value.name = "points.earned", variable = "Assignment.Name")
        df.tmp[, "Assignment.Name"] <- assignments
        df <- merge(df.tmp, df.assignments)
        df$pct <- with(df, points.earned/Total.Points)
        df[, "Student.Name"] <- NULL
        short.name <- gsub(" ", "", student)
        df.grades.anon <- df.grades
        df.grades.anon[, "Student.Name"] <- NULL
        assignment.summary <- print(xtable(summary(df.grades.anon)))
        report.contents <- c(header,
                             "\\section*{Grade Report for: ",
                             student,
                             "}", 
                             "\\subsection*{Assignments To Date}",
                             print(xtable(df.assignments)), 
                             "\\subsection*{Class Performance}", 
                             assignment.summary, 
                             "\\subsection*{Your Performance}", 
                             print(xtable(df)), "\\end{document}"
                             )
        #setwd(report.dir)
        out.file <- paste0(report.directory, "/", short.name, "_report.tex")
        writeLines(report.contents, out.file)
        system(paste0("pdflatex -output-directory=",report.directory," ", out.file))
    }
}
