import os
import pandas as pd
import multiprocessing as mp
from tqdm import tqdm
from utils import check_availability, unpickle_wordlist

dir_path = os.path.dirname(os.path.realpath(__file__))
pickle_path = os.path.join(dir_path, os.pardir, 'data', 'word_list.pickle')
avaliable_names_path = os.path.join(dir_path, os.pardir, 'data', 'available_usernames.csv')

def worker(word, queue):
    '''
    Receives a word and checks the availability
    of that word as a username
    '''
    if check_availability(word):
        result = (word, True)
    else:
        result = (word, False)
    queue.put(result)
    return result

def writer(queue):
    with open(avaliable_names_path, "w") as fd:
        while True:
            message = queue.get()
            if message == 'kill':
                tqdm.write('Writer process killed')
                break
            else:
                word, result = message
                fd.write('{},{}\n'.format(word, result))
                fd.flush()

if __name__ == "__main__":
    # Unpickle our preprocessed list of words
    word_list = unpickle_wordlist(pickle_path)
    num_process = mp.cpu_count() // 4
    print('Running {} processes'.format(num_process))

    manager = mp.Manager()
    queue = manager.Queue()
    pool = mp.Pool(num_process)
    file_writer = pool.apply_async(writer, (queue,))

    jobs = []
    for word in word_list:
        job = pool.apply_async(worker, (word, queue))
        jobs.append(job)

    for job in tqdm(jobs, smoothing=0.1):
        job.get()

    queue.put('kill')
    pool.close()
    pool.join