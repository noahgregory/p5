SHELL=/bin/bash
CXX=g++
CXXFLAGS=-std=c++14 -Wall -g
RM=rm -rf
TESTS=test-1-daily-stats test-2-monthly-stats

.PHONY: clean

# Target rules
main: main.o daily-stats.o monthly-stats.o text-menu-app.o
	$(CXX) -o $@ $^

test-all: $(TESTS)

test-1-daily-stats: test-1-daily-stats.o daily-stats.o
	$(CXX) -o $@ $^
	./$@

test-2-monthly-stats: test-2-monthly-stats.o monthly-stats.o daily-stats.o
	$(CXX) -o $@ $^
	./$@

# General compilation rules
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $<

test-run: main
	echo -e "not-exist.txt\ntemperatures.txt\n1\n06/01/2020\n1\n06/12/2021\n2\n3\n4\n" | ./main

test-output: main
	echo -e "not-exist.txt\ntemperatures.txt\n1\n06/01/2020\n1\n06/12/2021\n2\n3\n4\n" | ./main > output.txt
	-grep -q "Cannot open" output.txt
	-grep -q "06/12/2021" output.txt
	-grep -q "74.95" output.txt
	-grep -q "31 days" output.txt
	-grep -q "75.09" output.txt
	$(RM) output.txt

clean:
	$(RM) *.o main $(TESTS) *.gc* *.dSYM output.txt
