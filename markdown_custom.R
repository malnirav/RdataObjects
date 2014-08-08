#### Load libraries ####
libs <- c('knitr','markdown')
sapply(libs, require, character.only=TRUE)

#### External JS libraries for HTML header ####
jsInclude <- c("http://code.jquery.com/jquery-1.10.2.min.js", 
               "http://cdn.datatables.net/1.10.0/js/jquery.dataTables.js", 
               "http://cdn.datatables.net/plug-ins/e9421181788/integration/bootstrap/3/dataTables.bootstrap.js")

cssInclude <- c("http://cdn.datatables.net/plug-ins/e9421181788/integration/bootstrap/3/dataTables.bootstrap.css")

freeText <- "<script>$(document).ready(function() { $('#datTable').dataTable( { 'search': { 'regex': true }} );});</script>"

headers <- paste(c(sapply(jsInclude, 
                        function(x) sprintf("<script src='%s'></script>",x)),
                 sapply(cssInclude, 
                        function(x) 
                            sprintf("<link rel='stylesheet' type='text/css' href='%s'>",x)),
                 freeText),
                 collapse=" ")

#### make report ####
filename <- "markdown_custom.md"
knit("markdown_custom.Rmd", output = filename)

markdownToHTML(filename, paste0(filename,".html"), extensions=c('tables'),
               options=c(markdownHTMLOptions(defaults=TRUE),"toc"),
               header=headers, stylesheet="markdown_custom.css")
file.remove(filename)
