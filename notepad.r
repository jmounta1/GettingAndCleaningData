    library(XML)
    library(RCurl)
    fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
    xData <- getURL(fileURL)
    doc <- xmlParse(xData)
    rootNode <- xmlRoot(doc)
    xmlName(rootNode)
    zipcodes <- xpathSApply(rootNode,'//zipcode',xmlValue)
    zip_21231 <- sum(as.numeric(zipcodes == '21231'))
    
    library(jsonlite)
    jsonData <- fromJSON("http://api.github.com/users/jtleek/repos")
    names(jsonData)
    names(jsonData$owner)
    jsonData$owner$login
    
    myjson <- toJSON(iris,pretty = TRUE)
    cat(myjson)
    
    iris2 <- fromJSON(myjson)
    head(iris2)
    
    library(XML)
    library(RCurl)
    library(jsonlite)
    library(data.table)
    URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
    datum <- getURL(URL)
    DT <- fread(datum)
    
    library(httr)
    oauth_endpoints('github')
    
    myapp <- oauth_app('github',
                       key = '7f92cdb6b1bcd78ec8cc',
                       secret = '5fb36b1c4239b6efb88f4decfb52f5a1c91d5264'
    )
    
    github_token <- oauth2.0_token(oauth_endpoints('github'), myapp)
    
    gtoken <- config(token = github_token)
    req <- GET('https://api.github.com/users/jtleek/repos', gtoken)
    stop_for_status(req)
    content(req)
    req
    
    library(jsonlite)
    jsonData <- fromJSON('https://api.github.com/users/jtleek/repos')
    names(jsonData)
    
    library(sqldf)
    acs <- read.csv('ACSdata.csv')
    sqldf('select pwgtp1 from acs where AGEP < 50')
    unique(acs$AGEP)
    sqldf('select distinct AGEP from acs')
    
    library(XML)
    library(RCurl)
    library(jsonlite)
    library(data.table)
    URL <- 'http://biostat.jhsph.edu/~jleek/contact.html'
    jleek <- getURL(URL)
    jleek_data <- fread(jleek)
    
    con = url('http://biostat.jhsph.edu/~jleek/contact.html')
    htmlCode = readLines(con)
    close(con)
    htmlCode
    list <- nchar(htmlCode)
    list[10]
    list[20]
    list[30]
    list[100]
    
    SST <- read.fwf('getdata_wksst8110.for', skip = 4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
    SST
    View(SST)
    sum(SST$V4)
    