package concurrency

type WebsiteChecker func(string) bool

type result struct {
	string
	bool
}

func CheckWebsites(wc WebsiteChecker, urls []string) map[string]bool {
	results := make(map[string]bool)
	result_channel := make(chan result)

	for _, url := range urls {
		go func() {
			result_channel <- result{url, wc(url)}
		}()
	}

	for _ = range urls {
		r := <-result_channel
		results[r.string] = r.bool
	}

	return results
}
