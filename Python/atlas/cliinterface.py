class CLIInterface:
    """Class to implement the UI using CLI"""

    def input_field(self, options: str) -> None:
        parts = options.split(":")
        question = parts[1]
        if len(parts) == 2:
            return input(f"{question}: ")

        default = parts[2]

        return input(f"{question} [{default}]: ") or default

    def choose_value(self, field: str, values: list) -> str:
        if not values:
            return ""

        if len(values) == 1:
            return values[0]

        question = "\n".join(f"  {n+1}. {option}" for n, option in enumerate(values))
        question = f"{question}\nElija una opción: "

        while True:
            answer = input(f"{question}: ")
            try:
                num = int(answer)
            except ValueError:
                num = -1
            
            if num in range(1, len(values)):
                break

        return values[num-1]

    def check_field(self, fields: dict) -> str:
        question = ", ".join(f"{fields[field]} ({field})" for field in fields)

        while True:
            answer = input(f"{question}: ").upper()
            if answer in fields:
                break

        return fields[answer]