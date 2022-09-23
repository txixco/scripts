class Chips:
    total: int
    bet: int

    def __init__(self, total: int = 100) -> None:
        self.total = total
        self.bet = 0

    def win_bet(self) -> None:
        self.total += self.bet

    def lose_bet(self) -> None:
        self.total -= self.bet