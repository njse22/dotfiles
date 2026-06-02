import sys
from duckduckgo_search import DDGS

def search(query):
    with DDGS() as ddgs:
        results = [r['title'] + ": " + r['body'] for r in ddgs.text(query, max_results=5)]
        return "\n\n".join(results)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query = " ".join(sys.argv[1:])
        print(search(query))
