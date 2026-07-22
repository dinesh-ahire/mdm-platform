class StandardizationEngine:

    def execute(self):

        records = self.read_stream()

        for record in records:

            standardized = self.standardize(record)

            self.save(standardized)