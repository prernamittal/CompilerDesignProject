# Verilog Parser

## Overview

This repository contains the source code for a Verilog parser developed using Flex and Bison. The project aims to create a robust parser capable of handling various Verilog constructs, providing a foundation for Verilog code analysis and transformation.

## Components

1. **Flex Code (Lexer):**
   - `flex.l`: Defines the lexical rules and patterns to tokenize the Verilog source code.

2. **Bison Code (Parser):**
   - `bison.y`: Specifies the Verilog grammar rules and generates a parser for constructing the abstract syntax tree (AST).

3. **Context Free Grammar:**
    - `grammar.txt`: Specifies the Verilog Context Free grammar on which the code is written. Please note, defining all the rules of a programming language is out of scope for this project.

4. **Test Cases:**
    - The `input` directory contains a set of Verilog test cases to assess the parser's correctness and robustness. Feel free to add more test cases to enhance coverage.

## Getting Started

To build and run the Verilog parser:

1. Install Flex and Bison.
2. Compile the lexer and parser:
   ```bash
   flex flex.l
   bison -d bison.y
   gcc lex.yy.c -o fisac bison.tab.c
   ```

3. Run the parser:
   ```bash
   ./fisac input/input.txt
   ```
