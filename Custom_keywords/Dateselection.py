import pdb

from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import logging


@library
class Dateselection:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance('SeleniumLibrary')

    @keyword
    def compute_selector(self,Day,Mon,Date,Year):
        try:
            self.selLib.click_element(f"xpath://div[@aria-label='{Day} {Mon} {str(Date)} {str(Year)}']")
        except:
            try:
                for i in range(1,12):
                    self.selLib.click_element(f"xpath://span[@aria-label='Next Month']")
                    try:
                        self.selLib.click_element(f"xpath://div[@aria-label='{Day} {Mon} {str(Date)} {str(Year)}']")
                        break
                    except:
                        continue
            except:
                logging.info("Dates not present/ Input incorrectly")
