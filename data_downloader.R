library(httr)

max_const <- "U02.json"
base_url <- "https://results.elections.gov.mv/data/"
letter_pos = 1
number_pos = 1

while (TRUE) {
  #makes a file id in the format A01.json
  const = paste(LETTERS[letter_pos], sprintf("%02d" ,number_pos),".json", sep="")
  
  # attaches the file_id to the url
  url_ = paste(base_url, const, sep="")
  print(const)
  
  # checking whether the file_id is U02
  if (const == max_const) {
    break
  }
  if (GET(url_)$status ==200) {
    download.file(url_, paste("files/",const, sep=""))
    number_pos = number_pos + 1
  } else  {
    # if we get an error we reset the number position to 1
    # and move to next letter (eg C04 -> D01)
    number_pos = 1
    letter_pos = letter_pos + 1
  }
}

file.create(paste("files/_scraped on",Sys.time()))
    