config.load_autoconfig()

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "g": "https://www.google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "gh": "https://github.com/search?q={}",
    "ten": "https://translate.google.com/?sl=pt&tl=en&text={}",
    "tpt": "https://translate.google.com/?sl=en&tl=pt&text={}",
}

c.url.start_pages = ["https://www.google.com"]
c.url.default_page = "https://www.google.com"
