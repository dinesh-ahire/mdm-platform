from abc import ABC, abstractmethod

class BaseProcedure(ABC):

    def __init__(self, session):

        self.session = session

    def execute(self):

        self.before()

        self.process()

        self.after()

    @abstractmethod
    def process(self):

        pass