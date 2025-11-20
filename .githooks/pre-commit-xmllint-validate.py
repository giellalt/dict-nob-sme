#!/usr/bin/env python3

import subprocess
import sys
import os.path


def main():
    # files are passed in as positional args to the script, however many..
    files = sys.argv[1:]

    ret = 0
    for f in files:
        if os.path.basename(f) == "meta.xml":
            continue

        args = ["xmllint", "--valid", f]
        try:
            proc = subprocess.run(args, capture_output=True)
        except FileNotFoundError:
            print("Install the 'xmllint' program.")
            print("error: xmllint: command not found")
            return 1
        if proc.returncode != 0:
            print(proc.stderr.decode("utf-8"))
            ret = 1

    return ret


if __name__ == "__main__":
    #print(sys.argv)
    raise SystemExit(main())
