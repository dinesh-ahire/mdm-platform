config = ConfigLoader(session)

sources = config.get_sources()

dq_rules = config.get_dq_rules()

match_rules = config.get_match_rules()

survivorship = config.get_survivorship_rules()