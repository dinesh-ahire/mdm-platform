from datetime import datetime
import traceback


class Logger:

    def __init__(self, session, run_id):

        self.session = session
        self.run_id = run_id

    def info(self, message):

        print(f"[INFO] {message}")

    def warning(self, message):

        print(f"[WARNING] {message}")

    def error(self, message, exception=None):

        print(f"[ERROR] {message}")

        if exception:
            print(traceback.format_exc())