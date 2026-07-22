class MetadataManager:

    def __init__(self, session):

        self.session = session

    def start_pipeline(self, pipeline_name):

        ...

        return run_id

    def finish_pipeline(self, run_id):

        ...

    def fail_pipeline(self, run_id, error):

        ...