#!/data/data/com.termux/files/usr/bin/python


from os import listdir
from os.path import isfile, isdir, join, dirname
from prettytable import PrettyTable
from subprocess import call, check_output
from sys import exit
from textwrap import dedent


def banner():
    print(dedent(r'''            
    ===============================            
    ___  ___  __                   
     |  |__  |__)  |\/| |  | \_/   
     |  |___ |  \  |  | \__/ / \   
                                   
     __   __   __     __  ___  __  
    /__` /  ` |__) | |__)  |  /__` 
    .__/ \__, |  \ | |     |  .__/ 
    ______________________________
    Project by
    dmdhrumilmistry
    ______________________________
    '''))


def execute_cmd(command: str, chk_output: bool = False) -> (str | int):
    '''executes command'''
    command = command.split()

    if chk_output:
        return check_output(command, shell=True).decode('utf-8')

    return call(command, shell=True)


def get_sh_files(dir_path: str) -> list[str]:
    '''returns list of shell files in a directory'''
    return [f for f in listdir(dir_path) if isfile(join(dir_path, f)) and f.split('.')[-1] == 'sh']


def get_dirs(dir_path: str) -> list[str]:
    '''returns list of directories in a directory'''
    return [f for f in listdir(dir_path) if isdir(join(dir_path, f))]


def map_files(dir_path: str) -> dict:
    '''maps all files and folders in a subdirectories of a directory with depth 1'''
    # get and sanitize directories
    dirs = get_dirs(dir_path)
    dirs = [dir for dir in dirs if '.' not in dir]

    # create and return map
    map = {}
    for dir in dirs:
        map[dir] = {
            'files': get_sh_files(dir),
            'dirs': get_dirs(dir)
        }

    return map


def get_table(dir_path: str):
    # map data
    mapped_data = map_files(dir_path)
    print(mapped_data)

    # create and return table
    table = PrettyTable(['Dir', 'Files', 'Dirs'])

    # set column alignment
    table.align['Dirs'] = 'c'
    table.align['Files'] = 'c'
    table.align['Dirs'] = 'l'

    # add rows
    for dir in mapped_data:
        table.add_row([
            dir,
            '\n'.join(mapped_data[dir]['files']),
            '\n'.join(mapped_data[dir]['dirs'])
        ])

    return table


def print_table(dir_name: str) -> None:
    '''prints table for the specified directory'''
    # get and print table
    table = get_table(dir_name)
    print(table)


def start():
    '''starts Command Line User Interface'''
    try:
        # print banner
        banner()

        print_table(dirname(__file__))

        while True:
            command = input('>> ').strip().lower()
            # TODO: create and execute commands

    except EOFError or KeyboardInterrupt:
        print("[!] User Interrupted! Exiting.")
        exit()

    except Exception as e:
        print(f"[-] Exception: {e}")


if __name__ == '__main__':
    # start UI
    start()
