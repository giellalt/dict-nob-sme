"""This script parses a XML dictionary file and queries the Sentralt stadnamnregister API for translations"""

MISSING_DEP_HELP = """
cannot run due to missing dependencies. hint, run:
python -m venv .venv && . .venv/bin/activate && pip install -r stadnamn-requirements.txt
...and then try again. (remember to run `deactivate` in the shell when you're done)
"""

try:
    import requests
    from string import Template
    from lxml.etree import ElementTree, Element
    import lxml.etree as etree
    import re
except ImportError:
    exit(MISSING_DEP_HELP)

api_endpoint = "https://ws.geonorge.no/stedsnavn/v1/sted"
placequerystring = Template("?sok=$placename&utkoordsys=4258&treffPerSide=10&side=1")

iso_to_norwegian = {
    "sme": "Nordsamisk",
    "nob": "Norsk",
    "fkv": "Kvensk",
    "smj": "Lulesamisk",
    "sma": "Sørsamisk",
    "sms": "Skoltesamisk",
}
approved_statuses = [
    "vedtatt",
    "godkjent og prioritert",
]

def get_approved_translations(placename: str, to_iso: str) -> set:
    translations = set()
    response = requests.get(api_endpoint + placequerystring.substitute(placename=placename))
    response.raise_for_status()
    places = response.json()["navn"]
    for place in places:
        names = place["stedsnavn"]
        for name in names:
            if name["språk"] == iso_to_norwegian[to_iso] and name["skrivemåtestatus"] in approved_statuses:
                translations.add(name["skrivemåte"])
    return translations

def get_translation_iso_from_filename_or_prompt(filename: str) -> str:
    """From a filename like 'Prop_nobsme.xml', get the 
    translation iso, e.g. 'sme'. If this cannot be determined, 
    prompt the user for an answer"""
    iso_pair = re.sub("^.*_", "", filename.replace(".xml", ""))
    if len(iso_pair) == 6:
        to_iso = iso_pair[3:]
    else:
        print("Translation language cannot be determined from filename")
        to_iso = input("Please enter 3-letter iso code of the translation language: ")
    return to_iso

def get_dict_translations(e: Element) -> set:
    translations = set()
    mgs = e.findall("mg")
    for mg in mgs:
        tg = mg.find("tg")
        ts = tg.findall("t")
        for t in ts:
            translations.add(t.text)
    return translations

def sets_are_equal(set1: set, set2: set, strict: bool):
    if strict:
        return set1 == set2
    else:
        return set1.issubset(set2) or set2.issubset(set1)


def parse_xml(filename: str, strict: bool):
    to_iso = get_translation_iso_from_filename_or_prompt(filename)
    tree = etree.parse(filename)
    root = tree.getroot()
    for e in root:
        l = e.find("lg/l")
        ssr_trans = get_approved_translations(l.text, to_iso)
        if len(ssr_trans) > 0:
            dict_trans = get_dict_translations(e)
            if not sets_are_equal(ssr_trans, dict_trans, strict):
                print(l.text)
                print("SSR:  " + str(ssr_trans))
                print("Dict: " + str(dict_trans))
            


if __name__ == "__main__":
    print("Printing differences between Sentralt stadnamnregister and dictionary file")
    parse_xml("../src/Prop_nobsme.xml", strict=True)