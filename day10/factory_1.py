import re
import itertools
from functools import reduce
from dataclasses import dataclass
from typing import List, Tuple


@dataclass
class Machine:
    diagram: int
    buttons: List[int]
    minimal: int = 0

    def find_minimal_buttons(self) -> int:
        for i in range(1, len(self.buttons) + 1):
            if self._check_combinations_of_size(i):
                return i
        return 0

    def _check_combinations_of_size(self, size: int) -> bool:
        if size == 1:
            for button in self.buttons:
                if button == self.diagram:
                    return True
            return False
        
        for combination in itertools.combinations(self.buttons, size):
            result = reduce(lambda x, y: x ^ y, combination)
            if result == self.diagram:
                return True
        return False


def parse_diagram(diagram_str: str) -> int:
    content = re.findall(r'\[([^]]*)\]', diagram_str)[0]
    binary_str = content[::-1].replace("#", "1").replace(".", "0")
    return int(binary_str, 2)


def parse_buttons(line: str) -> List[int]:
    button_strs = re.findall(r'\(([^)]*)\)', line)
    buttons = []
    
    for button_str in button_strs:
        positions = [int(pos) for pos in button_str.split(',')]
        button_value = sum(2**pos for pos in positions)
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
            buttons = parse_buttons(line)
            machines.append(Machine(diagram, buttons))
        except (IndexError, ValueError) as e:
            print(f"Error parsing line: {line}. Error: {e}")
            continue
    
    return machines


def main():
    machines = parse_input_file("input.txt")
    
    total_minimal = 0
    for machine in machines:
        minimal = machine.find_minimal_buttons()
        machine.minimal = minimal
        total_minimal += minimal
    
    print(f"Total minimal buttons: {total_minimal}")


if __name__ == "__main__":
    main()