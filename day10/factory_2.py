import re
import itertools
from functools import reduce
from dataclasses import dataclass
from itertools import repeat
from typing import List, Tuple

# WIP
import sys
sys.setrecursionlimit(200000)

@dataclass
class Machine:
    diagram: int
    buttons: List[int]
    joltage: List[int]
    minimal: int = 0

    def find_element(self, current_list):
        for button in self.buttons:
            current_list.append(button)
            for element in current_list:
                result = [sum(x) for x in zip(element)]
                if result == self.joltage:
                    print(f"jajaja {result}")
                    return len(element)
                for i in range(len(self.joltage)):
                    if self.joltage[i] < result[i]:
                        return False
                return self.find_element(current_list)
        return False

    def find_minimal_buttons(self) -> int:
        for i in range(min(self.joltage), sum(self.joltage) + 1):
            if self._check_combinations_of_size(i):
                return i
        return 0

    def _check_combinations_of_size(self, size: int) -> bool:
        for combination in itertools.product(self.buttons, repeat=size):
            result = [sum(x) for x in zip(*list(combination))]
            if result == self.joltage:
                return True
        return False


def parse_diagram(diagram_str: str) -> int:
    content = re.findall(r'\[([^]]*)]', diagram_str)[0]
    binary_str = content[::-1].replace("#", "1").replace(".", "0")
    return int(binary_str, 2)


def parse_joltage(line: str) -> List[int]:
    content = re.findall(r'\{([^]]*)}', line)[0]
    return [int(j) for j in content.split(',')]


def parse_buttons(line: str, size: int) -> List[int]:
    button_strs = re.findall(r'\(([^)]*)\)', line)
    buttons = []

    for button_str in button_strs:
        positions = [int(pos) for pos in button_str.split(',')]
        button_value = list(map(int, list(format(sum(2 ** pos for pos in positions), f"0{size}b"))))
        buttons.append(button_value)

    return buttons


def parse_input_file(filename: str) -> List[Machine]:
    machines = []

    try:
        with open(filename, "r") as file:
            lines = file.read().splitlines()
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        return []
    except Exception as e:
        print(f"Error reading file: {e}")
        return []

    for line in lines:
        if not line.strip():  # Skip empty lines
            continue

        try:
            diagram = parse_diagram(line)
            joltage = parse_joltage(line)
            buttons = parse_buttons(line, len(joltage))
            machines.append(Machine(diagram, buttons, joltage))
        except (IndexError, ValueError) as e:
            print(f"Error parsing line: {line}. Error: {e}")
            continue

    return machines


def main():
    machines = parse_input_file("input_test.txt")

    total_minimal = 0
    for machine in machines:
        a = machine.find_element([])
        minimal = machine.find_minimal_buttons()
        machine.minimal = minimal
        total_minimal += minimal

    print(f"Total minimal buttons: {total_minimal}")


if __name__ == "__main__":
    main()
