"""This script parses a XML dictionary file and queries an Artsdatabanken API for translations"""

MISSING_DEP_HELP = """
cannot run due to missing dependencies. hint, run:
python -m venv .venv && . .venv/bin/activate && pip install -r python-api-requirements.txt
...and then try again. (remember to run `deactivate` in the shell when you're done)
"""

try:
    import requests
    import lxml.etree as etree
    from lxml.etree import Element
except ImportError:
    exit(MISSING_DEP_HELP)

api_endpoint = "https://webtjenester.artsdatabanken.no/legacy/Artsnavnebase.asmx/Artssok"

def is_correct_entry(LatinskNavn: Element, search_term: str, language: str = "Bokmål") -> bool:
    """Return True if the Element contains the exact search term
    as a name in the specified language. Needed as the API returns 
    all matches, including substrings.
    """
    Takson = LatinskNavn.find("{http://artsdatabanken.no/Artsnavnebase}Takson")
    for Popularnavn in Takson:
        if Popularnavn.get("Spraak") == language:
            for Navn in Popularnavn:
                if Navn.text == search_term:
                    return True
    return False

def return_translations(LatinskNavn: Element, language: str, only_recommended: bool) -> set:
    """Return translations in the specified language.
    'language' may be one of "Bokmål", "Nynorsk" and "Nordsamisk"
    If 'only_recommended' is set to True, just names with the attribute Anbefalt="true"
    will be returned.
    """
    trans = set()
    Takson = LatinskNavn.find("{http://artsdatabanken.no/Artsnavnebase}Takson")
    for Popularnavn in Takson:
        if Popularnavn.get("Spraak") == language:
            for Navn in Popularnavn:
                if only_recommended:
                    if Navn.get("Anbefalt") == "true":
                        trans.add(Navn.text)
                else:
                    trans.add(Navn.text)
    return trans

def get_adb_translations(search_term: str) -> set:
    """Return North saami translation(s) of the search term"""
    empty_trans = set()
    resp = requests.post(api_endpoint, {"Search": search_term})
    if resp.status_code == 200:
        cont = resp.content
        root = etree.fromstring(cont)
        for LatinskNavn in root:
            if is_correct_entry(LatinskNavn, search_term):
                return return_translations(LatinskNavn, "Nordsamisk", True)
    return empty_trans

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
    tree = etree.parse(filename)
    root = tree.getroot()
    for e in root:
        l = e.find("lg/l")
        adb_trans = get_adb_translations(l.text)
        if len(adb_trans) > 0:
            dict_trans = get_dict_translations(e)
            if not sets_are_equal(adb_trans, dict_trans, strict):
                print(l.text)
                print("Artsdb:  " + str(adb_trans))
                print("Dict:    " + str(dict_trans))
            


if __name__ == "__main__":
    print("Printing differences between Artsdatabanken and dictionary file")
    parse_xml("../src/N_nobsme.xml", strict=True)
    