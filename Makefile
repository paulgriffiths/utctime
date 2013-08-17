# UTC time class and functions library
# ====================================
# Copyright 2013 Paul Griffiths
# Email: mail@paulgriffiths.net
#
# Distributed under the terms of the GNU General Public License.
# http://www.gnu.org/licenses/


# Variables section
# =================

# Executable names
OUT=libutctime.a
TESTOUT=unittests
TESTOUT_D=unittests_d

# Install paths
#LIBRARY_INSTALL_PATH=~/lib/cpp
LIBRARY_INSTALL_PATH=/home/paul/lib/cpp
INCLUDE_INSTALL_PATH=/home/paul/include
INSTALL_HEADERS=utctime.h

# Compiler and archiver executable names
CXX=g++
AR=ar

# Compiler flags
CXXFLAGS=-std=c++98 -pedantic -Wall -Wextra -Weffc++
CXX_POSIX_FLAGS=-Wall -Wextra -Weffc++
CXX_DEBUG_FLAGS=-ggdb -DDEBUG -DDEBUG_ALL
CXX_RELEASE_FLAGS=-O3 -DNDEBUG

# Linker flags
LDFLAGS=
LD_TEST_FLAGS=-lCppUTest -lCppUTestExt -lutctime -L/home/paul/git/utctime
LD_TEST_FLAGS_D=-lCppUTest -lCppUTestExt -lutctime -L$(LIBRARY_INSTALL_PATH)

# Object code files
MAINOBJ=utctime.o
TESTMAINOBJ=tests/unittests.o
TESTMAINOBJ_D=tests/unittests_d.o

TESTOBJS=tests/test_tm_decrement_hour.o
TESTOBJS+=tests/test_tm_decrement_minute.o
TESTOBJS+=tests/test_tm_decrement_second.o
TESTOBJS+=tests/test_tm_increment_hour.o
TESTOBJS+=tests/test_tm_increment_minute.o
TESTOBJS+=tests/test_tm_increment_second.o
TESTOBJS+=tests/test_is_leap_year.o
TESTOBJS+=tests/test_tm_intraday_secs_diff.o
TESTOBJS+=tests/test_get_utc_timestamp.o
TESTOBJS+=tests/test_get_utc_timestamp_gb.o
TESTOBJS+=tests/test_get_utc_timestamp_eet.o
TESTOBJS+=tests/test_get_utc_timestamp_nsw.o
TESTOBJS+=tests/test_get_utc_timestamp_xxx.o
TESTOBJS+=tests/test_validate_date.o
TESTOBJS+=tests/test_utctime_comparison_operators.o
TESTOBJS+=tests/test_utctime_subtraction_operator.o
TESTOBJS_D=tests/test_deployed.o

# Source and clean files and globs
SRCS=$(wildcard *.cpp *.h)
SRCS+=$(wildcard tests/*.cpp)

SRCGLOB=*.cpp *.h
SRCGLOB+=tests/*.cpp

CLNGLOB=libutctime.a unittests
CLNGLOB+=*~ *.o *.gcov *.out *.gcda *.gcno
CLNGLOB+=tests/*~ tests/*.o tests/*.gcov tests/*.out tests/*.gcda tests/*.gcno


# Build targets section
# =====================

default: debug

# debug - builds objects with debugging info
.PHONY: debug
debug: CXXFLAGS+=$(CXX_DEBUG_FLAGS)
debug: main

# release - builds with optimizations and without debugging info
.PHONY: release
release: CXXFLAGS+=$(CXX_RELEASE_FLAGS)
release: main

# tests - builds unit tests
.PHONY: tests
tests: CXXFLAGS+=$(CXX_DEBUG_FLAGS)
tests: LDFLAGS+=$(LD_TEST_FLAGS)
tests: testmain

# tests_d - builds unit tests for deployed library
.PHONY: tests_d
tests_d: CXXFLAGS+=$(CXX_DEBUG_FLAGS) -I$(INCLUDE_INSTALL_PATH)
tests_d: LDFLAGS+=$(LD_TEST_FLAGS_D)
tests_d: testmain_d

# install - installs library and headers
.PHONY: install
install:
	@echo "Copying library to $(LIBRARY_INSTALL_PATH)..."
	@cp $(OUT) $(LIBRARY_INSTALL_PATH)
	@echo "Copying headers to $(INCLUDE_INSTALL_PATH)..."
	@cp $(INSTALL_HEADERS) $(INCLUDE_INSTALL_PATH)
	@echo "Done."

# clean - removes ancilliary files from working directory
.PHONY: clean
clean:
	-@rm $(CLNGLOB) 2>/dev/null

# lint - runs cpplint with specified options
.PHONY: lint
lint:
	@cpplint --verbose=5 --filter=-runtime/references,-build/header_guard,\
-readability/streams,-build/include,-legal/copyright,\
-runtime/threadsafe_fn,-whitespace/blank_line,-runtime/int,\
-build/namespaces \
$(SRCGLOB)

# check - runs cppcheck with specified options
.PHONY: check
check:
	@cppcheck --enable=all $(SRCGLOB)


# Executable targets section
# ==========================

# Main executable
main: $(MAINOBJ) $(OBJS)
	@echo "Creating library..."
	@$(AR) rcs $(OUT) $(MAINOBJ)
	@echo "Done."

# Unit tests executable
testmain: $(TESTMAINOBJ) $(TESTOBJS)
	@echo "Linking unit tests..."
	@$(CXX) -o $(TESTOUT) $(TESTMAINOBJ) $(TESTOBJS) $(LDFLAGS) 
	@echo "Done."

# Unit tests executable
testmain_d: $(TESTMAINOBJ) $(TESTOBJS_D)
	@echo "Linking unit tests..."
	@$(CXX) -o $(TESTOUT_D) $(TESTMAINOBJ) $(TESTOBJS_D) $(LDFLAGS) 
	@echo "Done."


# Object files targets section
# ============================

# Main program

utctime.o: utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<


# Unit tests

tests/unittests.o: tests/testmain.cpp
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_decrement_hour.o: tests/test_tm_decrement_hour.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_decrement_minute.o: tests/test_tm_decrement_minute.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_decrement_second.o: tests/test_tm_decrement_second.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_increment_hour.o: tests/test_tm_increment_hour.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_increment_minute.o: tests/test_tm_increment_minute.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_increment_second.o: tests/test_tm_increment_second.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_tm_intraday_secs_diff.o: tests/test_tm_intraday_secs_diff.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_is_leap_year.o: tests/test_is_leap_year.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_get_utc_timestamp.o: tests/test_get_utc_timestamp.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_get_utc_timestamp_gb.o: tests/test_get_utc_timestamp_gb.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXX_POSIX_FLAGS) -c -o $@ $<

tests/test_get_utc_timestamp_eet.o: tests/test_get_utc_timestamp_eet.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXX_POSIX_FLAGS) -c -o $@ $<

tests/test_get_utc_timestamp_nsw.o: tests/test_get_utc_timestamp_nsw.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXX_POSIX_FLAGS) -c -o $@ $<

tests/test_get_utc_timestamp_xxx.o: tests/test_get_utc_timestamp_xxx.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXX_POSIX_FLAGS) -c -o $@ $<

tests/test_validate_date.o: tests/test_validate_date.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_utctime_comparison_operators.o: \
	tests/test_utctime_comparison_operators.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_utctime_subtraction_operator.o: \
	tests/test_utctime_subtraction_operator.cpp \
	utctime.cpp utctime.h
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

tests/test_deployed.o: tests/test_deployed.cpp
	@echo "Compiling $<..."
	@$(CXX) $(CXXFLAGS) -c -o $@ $<
