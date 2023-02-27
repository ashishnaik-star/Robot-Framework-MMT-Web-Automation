import time

from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import logging


@library
class Searchpageelements:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance('SeleniumLibrary')

    @keyword
    def element_occurrence(self, xpath, timeout=10):
        time.sleep(3)
        try:
            self.selLib.wait_until_element_is_visible(xpath, timeout=timeout)
            self.selLib.click_element(str(xpath))
        except:
            logging.info(f"element not visible inb page{xpath}")

