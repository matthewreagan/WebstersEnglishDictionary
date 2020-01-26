import os
import pandas
from tqdm import tqdm
from utils import check_availability, unpickle_wordlist

dir_path = os.path.dirname(os.path.realpath(__file__))
pickle_path = os.path.join(dir_path, os.pardir, 'data', 'word_list.pickle')
avaliable_names_path = os.path.join(dir_path, os.pardir, 'data', 'available_usernames.txt')

if __name__ == "__main__":
    # Unpickle our preprocessed list of words
    word_list = unpickle_wordlist(pickle_path)

    # Iterate through the list of words,
    # while saving the still available usernames
    # to a list
    available_usernames = []

    for word in tqdm(word_list):
        if check_availability(word):
            tqdm.write('{} is available'.format(word))
            available_usernames.append(word)

    # We then save the list of available usernames 
    # to a text file
    with open(avaliable_names_path, "w") as fd:
        fd.writelines(available_usernames)
