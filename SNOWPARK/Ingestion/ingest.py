class IngestionEngine:

    def __init__(self, context):

        self.context = context

    def execute(self):

        sources = self.context.config.get_sources()

        for source in sources:

            self.process_source(source)