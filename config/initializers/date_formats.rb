# frozen_string_literal: true

# This has caused the html min/max to not work
# The attributes value, min and max have the same format for dates. They follow the RFC 3339 where the full data syntax is as:
# https://stackoverflow.com/questions/17443034/input-type-date-min-and-max-values-validate-against-yyyy-mm-dd-instead-of-dd-mm
# Date::DATE_FORMATS[:default] = '%d/%m/%Y'

