import pickle
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

# https://www.instagram.com/{username}/?__a=1
url = 'https://www.instagram.com/'
retries = Retry(total = 9,
                backoff_factor = 30,
                status_forcelist = [104, 500, 502, 503, 504])

def check_availability(username:str):
    '''
    Makes a request to instagram's website.
    If a 200 response is returned, the username is taken.
    Otherwise, if a 404 reponse is returned, the username is available.
    '''
    webpage = 'https://www.instagram.com/{}/?__a=1'.format(username)

    sess = requests.Session()
    sess.mount(url, HTTPAdapter(max_retries=retries))
    response = sess.get(webpage)
    status = response.status_code

    if status == 404:
        return True
    elif status in [200, 302]:
        return False

def unpickle_wordlist(path):
    with open(path, 'rb') as fd:
        wordlist = pickle.load(fd)
    return wordlist
