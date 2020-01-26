import requests

def check_availability(username:str):
    '''
    Makes a request to instagram's website.
    If a 200 response is returned, the username is taken.
    Otherwise, if a 404 reponse is returned, the username is available.
    '''
    # https://www.instagram.com/{username}/?__a=1
    webpage = 'https://www.instagram.com/{}/?__a=1'.format(username)
    response = requests.get(webpage)
    status = response.status_code

    if status == 404:
        return True
    elif status == 200:
        return False
    else:
        # TODO: In future, we'd want to handle other
        # error codes properly as well.
        print(status)
        raise ValueError