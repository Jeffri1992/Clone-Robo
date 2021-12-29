import re

regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
class ValidateEmailFunction(object):
  def check_validate_email(self, email):
      '''Keyword for check validate email'''
      if(re.match(regex, email)):
        return True
      else:
        return False
