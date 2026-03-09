#!/usr/bin/env python3

import os
import sys
import unicodedata

REPLACEMENTS = {
    "\u00a0": " ",  # Non-breaking space
}


def clean_xml(filepath):
    changed = False
    temp_path = filepath + ".tmp"

    with open(filepath, "r", encoding="utf-8") as f_in, open(
        temp_path, "w", encoding="utf-8"
    ) as f_out:

        for line in f_in:
            new_line = line
            # Manual replacements. For now only non breaking space, but can be expanded
            for bad, good in REPLACEMENTS.items():
                new_line = new_line.replace(bad, good)

            # Normal form C (turns decomposed letters into composed ones: 'á', 'â', 'é', etc.)
            new_line = unicodedata.normalize("NFC", new_line)

            if new_line != line:
                changed = True
            f_out.write(new_line)

    if changed:
        os.replace(temp_path, filepath)
    else:
        os.remove(temp_path)
    return changed


def main():
    # files are passed in as positional args to the script, however many..
    files = sys.argv[1:]

    any_changed = False
    for f in files:
        if os.path.basename(f) == "meta.xml":
            continue

        if clean_xml(f):
            print(f"Normalized Unicode in: {f}")
            any_changed = True

    if any_changed:
        print("\n\033[91mIMPORTANT:\033[0m")
        print(
            'The files above were modified and need to be restaged (git add "filename") before running git commit again.'
        )

    return int(any_changed)


if __name__ == "__main__":
    # print(sys.argv)
    raise SystemExit(main())
