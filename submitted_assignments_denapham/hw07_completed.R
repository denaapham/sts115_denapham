# load in library
library("xml2") # to parse xml

# Cal Aggie ---------------------------------------------------------------

# pasted over the code we put together in class to scrape links from
# the first page of "Features" on the Cal Aggie site and pasted it into the 
# code from the course reader so the link extraction will scrape multiple pages of links 
# the previous code from the reader was no longer working since the ids have changed 

parse_article_links = function(page) { # creating a function that extracts the links from the page
  # Get article URLs
  blocks = xml_find_all(page, '//div[@class="tdb_module_loop td_module_wrap td-animation-stack td-cpt-post"]') # find the section of the webpage thtat contains the articles
  block_headers = xml_find_all(blocks, './/h3[@class="entry-title td-module-title"]') # finds the article titles 
  block_links = xml_find_all(block_headers, './/a') # looks for a element anchor tags 
  urls = xml_attr(block_links, 'href') # retrieves the links 
  
  # Get next page URL
  nav = xml_find_all(page, "//div[contains(@class, 'page-nav')]") # finds the element the navigates to the next page
  next_page = xml_find_all(nav, ".//a[contains(@aria-label, 'next-page')]")
  
  if (length(next_page) == 0) { # if we're on the last page the next page url will be set to NA
    next_url = NA
  } else {
    next_url = xml_attr(next_page, "href")
  }
  
  # Using a list allows us to return two objects
  list(urls = urls, next_url = next_url)
}


url = "https://theaggie.org/category/features/" # the url of beginning page of the site we will be scraping
article_urls = list() # empty list to store the urls
i = 1 # number that will apend every loop keeping track of the page we're on


while (!is.na(url) & i <= 5) { # continue the loop while the url is not an NA value and i is less than five
  # as mentioned in discussion we should only scrape the first five pages, if you wanted to scrape all the pages remove the second condition 
  # the while loop would just be, while (!is.na(url))
  
  # Download and parse the page.
  page = read_html(url)
  result = parse_article_links(page)
  
  # Save the article URLs in the `article_urls` list. The variable `i` is the
  # page number.
  article_urls = c(article_urls, result$urls) # the links from the current page are added to the list of article urls 
  print(paste("Scraping page", i, ":", url)) # keeps track of what article is being scraped are the url of that page 

  
  # Set the URL to the next URL.
  url = result$next_url
  i = i + 1 # page counter increases by 1
  
  # Sleep for 1/30th of a second so that we never make more than 30 requests
  # per second.
  Sys.sleep(1/30) 
  
}