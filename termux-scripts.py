#!/data/data/com.termux/files/usr/bin/python


from os import chdir, listdir, name, getcwd
from os.path import isfile, isdir, join, dirname
from prettytable import PrettyTable
from subprocess import call, check_output
from sys import exit
from textwrap import dedent

# global variables
ROOT_DIR = dirname(__file__)


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

    # add current directory to dirs list
    # it'll be used to print curr dir scripts
    # in get_table function
    dirs.insert(0, '.')

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
    print(get_table(dir_name))


def print_help():
    # create help menu table and align cols
    help = PrettyTable(['Command', 'Description'])
    help.align['Command'] = 'c'
    help.align['Description'] = 'l'

    # add commands
    help.add_row(['help', 'prints commands along with description'])
    help.add_row(['exit', 'exits TermuxScripts console'])
    help.add_row(['clear', 'clears console'])
    help.add_row(['show', 'print options in current directory'])
    help.add_row(['select', 'selects a directory, eg. select Installation'])
    help.add_row(['back', 'move one directory back'])
    help.add_row(['run', 'runs a script eg. run GooglePhish.sh'])
    # help.add_row(['',''])

    # print help menu
    print(help)


def start():
    '''starts Command Line User Interface'''
    try:
        # print banner
        banner()

        while True:
            command = input('>> ').strip().split()
            cmd_len = len(command)

            match command[0].lower():
                case 'help':
                    print_help()

                case 'clear':
                    cmd = 'cls' if name == 'nt' else 'clear'
                    call(cmd, shell=True)

                case 'exit':
                    exit(0)

                case 'show':
                    print_table(getcwd())

                case 'back':
                    if getcwd() != ROOT_DIR:
                        chdir('..')
                    else:
                        print("[!] Cannot move out of the Project folder")

                case 'select':
                    if cmd_len >= 2 :
                        dirname = command[1]
                        new_dir = join(getcwd(), dirname)

                        # change directory if new_dir is valid
                        if isdir(new_dir) and ROOT_DIR in new_dir:
                            chdir(new_dir)
                        else:
                            print("[!] Directory does not exists/Cannot Move out of Project Folder")
                    else:
                        print(
                            "[!] Directory name is required. example: select directory_name")
                
                case 'run':
                    if cmd_len >= 2:
                        sh_file_name = command[1]
                        file_path = join(getcwd(), sh_file_name)

                        if isfile(file_path) and ROOT_DIR in file_path:
                            print(f"[*] Starting {sh_file_name}")
                            call(['bash', file_path], shell=True)
                        else:
                            print("[!] Invalid File Path")

                case _:
                    print("[-] Invalid Command, use help for to print commands.")

    except KeyboardInterrupt or EOFError:
        print("\n[!] Exiting.")
        exit()

    except Exception as e:
        print(f"[-] Exception: {e}")


if __name__ == '__main__':
    # start UI
    start()
