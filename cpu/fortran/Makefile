FC = gfortran
FFLAGS = -O3 -march=native

TARGET = fortran_cpu_test

# The correct compilation order:
# 1. matmul.f90  (produces matmul_mod.mod)
# 2. util.f90    (produces util_mod.mod)
# 3. main.f90    (references both modules)

OBJ = matmul.o util.o main.o

all: run

$(TARGET): $(OBJ)
	$(FC) $(FFLAGS) $(OBJ) -o $(TARGET)

matmul.o: matmul.f90
	$(FC) $(FFLAGS) -c matmul.f90

util.o: util.f90
	$(FC) $(FFLAGS) -c util.f90

main.o: main.f90
	$(FC) $(FFLAGS) -c main.f90

run: $(TARGET)
	./$(TARGET)

verify: run
bench: run

clean:
	rm -f $(TARGET) *.o *.mod results_fortran_*.csv

.PHONY: all run verify bench clean
