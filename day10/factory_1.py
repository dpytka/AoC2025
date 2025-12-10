import re
from dataclasses import dataclass
import itertools
from functools import reduce


@dataclass
class Machine:
    diagram: int
    buttons: list
    minimal: int = 0


lines = open("input.txt", "r").read().splitlines()
machines = []
for line in lines:
    diagram = int(re.findall(r'\[([^)]*)]', line)[0][::-1].replace("#", "1").replace(".", "0"),2)
    buttons = [
        sum([2**int(b) for b in button.split(',')])
        for button in re.findall(r'\(([^)]*)\)', line)
    ]
    m = Machine(diagram, buttons)
    machines.append(m)


for m in machines:
    for i in range(1, 100000):
        if i == 1:
            combinations = m.buttons
        else:
            combinations = list(itertools.combinations(m.buttons, i))
        for combination in combinations:
            if i == 1:
                res = combination
            else:
                res = reduce(lambda x, y: x ^ y, combination)
            if res == m.diagram:
                m.minimal = i
                break
        if m.minimal > 0:
            break

print(sum(map(lambda x: x.minimal, machines)))